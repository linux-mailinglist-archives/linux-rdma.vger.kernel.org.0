Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46A8204C7
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEPLeA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 16 May 2019 07:34:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37512 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEPLeA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 07:34:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so4788936edw.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 04:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1sPqbV4yg6PQhkcAZ2TdIb5Utgy2p6bP52sSdCbpwE=;
        b=pM2mrTOI4zICDYlTPLGPguverrmDPoGnv5nSaaXZ9O33/Uwy7vg0F0xWdtrBWqsRt+
         sof8I5mepDPXtUt0up3g4sTqXMbAPuhP1juI+4/dvJlVJSXxBWZdYyRNkyjeofvEDuhR
         5wTuQ6DUZ5BU7UP8qHhDdVDHhNl8QkHEp88RgCn0fOgc633DIdaE+7pO1CAG3UIVrEt/
         vPkhD+GF76nOomPzXxH2tJ3BBqbmhlxcN+WU68MkfjHXCyC6CXoFPkDzwHBo7Nvf8Dm1
         Nx4Ef6vSNxWBtc+moT0WEoLclJSuOPAUliMuVH3C0j1A5KppTvrdwKeH7pqJZqWyZJxj
         ZcwQ==
X-Gm-Message-State: APjAAAXd0AJFOCQyt2A9Y2nlkrx8OXrXDoEbruFB7ZCVZbrRJnJNXk5c
        7ylHFSqIEoI+0NUTMGU+W7UUKeW0
X-Google-Smtp-Source: APXvYqzZDpVQM143vLCYnPLF8wzlbqDhTl9cRu7nCEQcvCKr0JGDLBPVZ7pA/grDsgpwY1tNtd74Xg==
X-Received: by 2002:a17:906:2a92:: with SMTP id l18mr8760415eje.181.1558006438445;
        Thu, 16 May 2019 04:33:58 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id d8sm1037336ejm.29.2019.05.16.04.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 04:33:57 -0700 (PDT)
Subject: Re: [PATCH rdma-next v3] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190516065738.1423-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b765380c-6477-6574-6863-74eb4f1e6b1c@acm.org>
Date:   Thu, 16 May 2019 13:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516065738.1423-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/16/19 8:57 AM, Leon Romanovsky wrote:
> +static void srp_rename_dev(struct ib_device *device, void *client_data)
> +{
> +	struct srp_device *srp_dev = client_data;
> +	struct srp_host *host, *tmp_host;
> +> +	list_for_each_entry_safe(host, tmp_host, &srp_dev->dev_list, list) {
        ^^^^^^^^^^^^^^^^^^^^^^^^
Would list_for_each_entry() have been sufficient?

> +		char name[IB_DEVICE_NAME_MAX * 8];

Why "* 8"? Would "+ 8" have been sufficient?

Otherwise this patch looks good to me. This patch also passes the tests
I ran.

Thanks,

Bart.

