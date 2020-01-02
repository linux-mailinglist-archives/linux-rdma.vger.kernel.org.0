Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52712EF12
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 23:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgABWed (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 17:34:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45014 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbgABWed (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 17:34:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so22545627pgl.11;
        Thu, 02 Jan 2020 14:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8mVvbAyQUW31vtCB7au92EGbYazy736+WkClVlaU2E0=;
        b=SkH84y9Kc6c1gxSiWpFkpNWuml4KFD3mC5SIXA3wzffzsTg2dx8fDVQaKwq/3ZsOJx
         Eba9sKAf7WjT+mphyWQKUEAgbp4Zq9AKkQVwchQjMbKxcWMWkt917ChcfsVR2fmTDA2s
         XdQgARIQf/n7mJ/YuBcIH6sSjzFriRkUJRP6HOvi4B2vCB/SobZ1nirgj0VT3HebEmsD
         dxc84USgLDybXj9HFwZi5yC/DK/6qJSVRsV0QK+tyTTkudsCj61mJoyueE8TPjTo08Wl
         FGHGYKq8l1hGJ65eoPeuxUXDafUFdVUpeaA+dT/xthqwpIf9RJlPsqOJ6JEcl9Xt61hX
         dVkw==
X-Gm-Message-State: APjAAAUjXallXNuEeM3bDq3fiWWWSeZFqkstORZ62jMPtcNOHVdxzPVS
        l9VmjUegUIwe4hxIyD1buEM=
X-Google-Smtp-Source: APXvYqzRXAPVdCIewiz9WFuQlrMZDrTyt9R+nWJ8bKFMmTlpu+xdIZnMCAjsyFlXH3I3x8W7+auR1g==
X-Received: by 2002:a63:2bcd:: with SMTP id r196mr90058338pgr.65.1578004472447;
        Thu, 02 Jan 2020 14:34:32 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n1sm65339662pfd.47.2020.01.02.14.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 14:34:31 -0800 (PST)
Subject: Re: [PATCH v6 15/25] rnbd: private headers with rnbd protocol structs
 and helpers
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-16-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f8ec030c-9279-c5c0-617b-26305327a3b0@acm.org>
Date:   Thu, 2 Jan 2020 14:34:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-16-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> + * @device_id:		device_id on server side to identify the device

Is this a number that only has a meaning inside the RTRS software? Is 
the role of this number perhaps similar to an NVMe namespace or SCSI 
LUN? If so, please mention this. Additionally, does this number start 
from zero or from one?

> + * @max_segments:	max segments hardware support in one transfer

Which "hardware" does this comment refer to? The RDMA adapter or the 
block device in the server? In the latter case, what if the block device 
has been implemented in software?

What kind of transfer does this comment refer to? A DMA transfer? If so, 
please mention this.

> +struct rnbd_msg_open_rsp {
> +	struct rnbd_msg_hdr	hdr;
> +	__le32			device_id;
> +	__le64			nsectors;
> +	__le32			max_hw_sectors;
> +	__le32			max_write_same_sectors;
> +	__le32			max_discard_sectors;
> +	__le32			discard_granularity;
> +	__le32			discard_alignment;
> +	__le16			physical_block_size;
> +	__le16			logical_block_size;
> +	__le16			max_segments;
> +	__le16			secure_discard;
> +	u8			rotational;
> +	u8			reserved[11];
> +};

Thanks,

Bart.
