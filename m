Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D10D29DBAF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbgJ2ALZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 20:11:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42982 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731875AbgJ1Wqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:46:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id s22so713067pga.9;
        Wed, 28 Oct 2020 15:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oatMflBbvtVoFbzfhbNEDvGH+eoG5r1OUVv4RU4nvk4=;
        b=hcnkdHhtqWBL0kf4N9Pb2Hgam3t5OK9ORRmqjwwzzRUOOo0PN0wUj7Ki9/XMmZg8SO
         GM4dvd1bE/UimigiqxNLIh7zLboAfaLyAgtCjL8IBbEjdlMrnlb3FEW3eS7i5OvHiB9B
         boyOAu67VfdBQImB3D+lw7cgoJZMeuxzslGGfubVWkR8iWKCgEU+hf5a4DkRCUUEpAOH
         C94S9W71s6hxII0B9ASEFFmQjVJLUOIV0weX9qIsYlzPKrLgUI0lhA49iEakr+B7u09q
         rFKBwjIlGut/5M5imGud6BvbTp8FALVaH1U4x5b8EZujYndJwiylojF4WHpkNlCgXwo/
         qqvg==
X-Gm-Message-State: AOAM531kI6v4839qxIPMaKLzsBRoF///KBVkXRjGarCVR0C0STpgxhXd
        qL1St8FRYDWBTA9yuJu9vZcB/GHQboPAvQ==
X-Google-Smtp-Source: ABdhPJzy2uuO9GujIGNJL1JsizVekBJIiPMa5j0MOcXzQbtLtnddVMaI2cP33Pc3xmuN/SwUEeZNEQ==
X-Received: by 2002:a05:6a00:16c7:b029:163:ce86:1d5d with SMTP id l7-20020a056a0016c7b0290163ce861d5dmr5239143pfc.80.1603856713993;
        Tue, 27 Oct 2020 20:45:13 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q23sm3879617pfg.192.2020.10.27.20.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:45:13 -0700 (PDT)
Subject: Re: [PATCH rdma-next v1] IB/srpt: Fix memory leak in srpt_add_one
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
        target-devel@vger.kernel.org
References: <20201027055920.1760663-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1bc9ef14-4d91-6b12-f396-222cb6775ce4@acm.org>
Date:   Tue, 27 Oct 2020 20:45:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201027055920.1760663-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/26/20 10:59 PM, Leon Romanovsky wrote:
> +/**
> + * srpt_unregister_mad_agent - unregister MAD callback functions
> + * @sdev: SRPT HCA pointer.
> + *
> + * Note: It is safe to call this function more than once for the same device.
> + */
> +static void srpt_unregister_mad_agent(struct srpt_device *sdev)
> +{
> +	__srpt_unregister_mad_agent(sdev, sdev->device->phys_port_cnt);
> +}

As far as I can see with this patch applied srpt_unregister_mad_agent()
has no callers. So please add an argument to srpt_unregister_mad_agent()
instead of introducing __srpt_unregister_mad_agent().

Thanks,

Bart.
