Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0FC29A2A7
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 03:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411495AbgJ0CWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 22:22:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44356 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438662AbgJ0CWL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 22:22:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id h2so5665878pll.11;
        Mon, 26 Oct 2020 19:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qe548AwnXNuPEjqrAM3SsypoEcJbrqy3/s6FtpJJ68=;
        b=tXxXyAu58FC0P1poC4YYZFvYDfGXaiYxAbjHJn67Rk2o9L9c4My0n0blNx45wHuJHL
         IWVePK05xFsxeAgIk3Uiuf+RbX8U+gPW6JU4ZbcOakS1b8z2ujfdSOD/+VZr4SYhvV8f
         u2iEOGorI6YnhrmgmqWIN1enJ3ZCVMwKeP5i73VIAROdVtQ/LS4wYwlTnvY81yl2ZIUv
         vkDEsezYjFiKCwxG7po9kZ5fpCFcJkT+pbL1lQ21p2TQBmt3U73u1cZe/6VuLRERZgYO
         D0PJbE5hByLEtNXfwKBieLOAsaeye/VK8yNWlwFQb0+MmSywNlG64I0Xa+t/7EWVkp4Z
         eHOg==
X-Gm-Message-State: AOAM5319hU0hj7skQM3f+P4oGRw/dOiw0C1+3vRbtWPR9LFYYeogrLa/
        kF+nN+DTeBZQjEK5L3R5l4xrx4mZZ+GEew==
X-Google-Smtp-Source: ABdhPJyPUvdmmntjHVSr3YCP9K4Bg+584ZENuTLduMgH16FqbyvnGUkBYIQAYMMrindbDCsqNcVBSw==
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr239895pjb.228.1603765330158;
        Mon, 26 Oct 2020 19:22:10 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 13sm82347pfj.100.2020.10.26.19.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 19:22:09 -0700 (PDT)
Subject: Re: [PATCH rdma-next] IB/srpt: Fix memory leak in srpt_add_one
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
        target-devel@vger.kernel.org
References: <20201026132737.1338171-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <93385ff4-cab7-05f2-e29a-82c9c71e47fa@acm.org>
Date:   Mon, 26 Oct 2020 19:22:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201026132737.1338171-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/26/20 6:27 AM, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> In case srpt_refresh_port failed for the second port, then
> we don't unregister the MAD agnet.
                              ^^^^^
                              agent?

The commit message is incomplete. Why does this patch have a Fixes tag?
The commit message should explain this but doesn't explain this.

What does this patch actually change? ib_unregister_mad_agent() is only
called by the current code if sport->mad_agent != NULL.

> -static void srpt_unregister_mad_agent(struct srpt_device *sdev)
> +static void __srpt_unregister_mad_agent(struct srpt_device *sdev, int port_cnt)
>  {
>  	struct ib_port_modify port_modify = {
>  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
> @@ -633,7 +627,10 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
>  	struct srpt_port *sport;
>  	int i;
>  
> -	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
> +	if (!port_cnt)
> +		return;
> +
> +	for (i = 1; i <= port_cnt; i++) {
>  		sport = &sdev->port[i - 1];
>  		WARN_ON(sport->port != i);
>  		if (sport->mad_agent) {

If this patch is retained, please leave the if-test out if you agree
that it is not necessary. I'm concerned that it will confuse readers.

Thanks,

Bart.
