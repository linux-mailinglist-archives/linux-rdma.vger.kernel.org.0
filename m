Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E9172C1D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 00:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgB0XOx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 18:14:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42621 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgB0XOx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 18:14:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so858120otd.9
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 15:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rp0PxYea93t1WRQ8q7wpuJfUZE+nI/QnHvJZCfZFKCI=;
        b=mWRvzpEyr9Bz/iiGIufAU1oPhAYuocP5TS8ZWcmYQStEtT7fAzCumLNbvxLnUkuYsp
         2lTRLzvogwWHEnRRfyXWxxzJ/ikg1N8//AGm6yaYR7yBvg1t0yL+CFIC7uuOCRh8bHOU
         CG0f55MI+S5hcVcVpP8TvX9PYwBosZ2L/wdlCPZghEJ4qZhUKF/95f1sMMTAskMhvg/L
         trqgUPG4QAQprma8KqOvBUQF6pE7eb6zgIGoq58zBs9gPYyY3/qiZqWIH4tojCimsFvS
         VEoXNuSN+mA1n8LWNDV5maLBLcNl18MyKIobPB31G4dj93Gq+8zLkDqBBH2Mmm9SMjnh
         PpYw==
X-Gm-Message-State: APjAAAWqMVtcY4xu4l2Lj6KGgwB8w8gCYNcB6oYh9vaQL9nziT0tSk4R
        WOKOHGuuNgSKuZkVqhn0Mxw=
X-Google-Smtp-Source: APXvYqwKPFeb84SSFr76aajZgm95CA/DS9tP0Aq1G9m3lwkC7XsJkxEC93UopooFtd3nzHIErQTamQ==
X-Received: by 2002:a05:6830:612:: with SMTP id w18mr1080149oti.160.1582845291362;
        Thu, 27 Feb 2020 15:14:51 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o15sm67404ote.2.2020.02.27.15.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 15:14:50 -0800 (PST)
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>, jgg@ziepe.ca
Cc:     linux-nvme@lists.infradead.org, hch@lst.de,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
 <20200227154220.GA3153@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
Date:   Thu, 27 Feb 2020 15:14:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200227154220.GA3153@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> The patch doesn't say if this is an actual bug you are seeing or
>> theoretical.
> 	
> I've noticed this issue while running the below fio command:
> fio --rw=randwrite --name=random --norandommap --ioengine=libaio
> --size=16m --group_reporting --exitall --fsync_on_close=1 --invalidate=1
> --direct=1 --filename=/dev/nvme2n1 --iodepth=32 --numjobs=16
> --unit_base=1 --bs=4m --kb_base=1000
> 
> Note: here NVMe Host is on SIW & Target is on iw_cxgb4 and the
> max_pages_per_mr supported by SIW and iw_cxgb4 are 255 and 128
> respectively.

This needs to be documented in the change log.

>>> The proposed patch enables host to advertise the max_fr_pages(via
>>> nvme_rdma_cm_req) such that target can allocate that many number of
>>> RW ctxs(if host's max_fr_pages is higher than target's).
>>
>> As mentioned by Jason, this s a non-compatible change, if you want to
>> introduce this you need to go through the standard and update the
>> cm private_data layout (would mean that the fmt needs to increment as
>> well to be backward compatible).
> 
> Sure, will initiate a discussion at NVMe TWG about CM private_data format.
> Will update the response soon.
>>
>>
>> As a stop-gap, nvmet needs to limit the controller mdts to how much
>> it can allocate based on the HCA capabilities
>> (max_fast_reg_page_list_len).

Sounds good, please look at capping mdts in the mean time.
