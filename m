Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31AE16AE66
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXSNo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 13:13:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40840 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSNn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 13:13:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so5751550pfb.7
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wU67S70FwkpVDqrP3T9nk/ru5Rq6SwtNjY29vxPkM5U=;
        b=A+wnwSn5fn9OeJb02H9haqi44KiCTmVY9wg/t/7ivTO+1kgFE9YhAKkd5GqyTaTLTX
         5DQU3gEOSurU21GrtqOlwofpabzxDWFBB637pF/7dXr2ZWOnjK9HyM5AeXwXHmD9gL8x
         1ru8Q3UzROceRXnoi2fOI/njKb0WyHUm1fNL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wU67S70FwkpVDqrP3T9nk/ru5Rq6SwtNjY29vxPkM5U=;
        b=i/X0CnvQGArPEeFzdgrUIh/DrA6XKyd3kXQguXw7xh146CclZKUbPTCgv0bOg5BXTW
         rZZPf5+FOjq2kMWpIgtFjcc5TLQHboyO+CN9acP4GvxdR9rL11SQYTj7YmEpYRUpSGLX
         l3jBxpAJ/sqmdY/ttd9tUzQSg0EcZorxIsYp+XkPZcRPuhQskciwNTFjQ5JdoLEZnimD
         38QhOPyQwsTq034oxJZSRXl5iMqIXawSnjzUchiokfnDoFki6MHBNzqRykAlyrOmlgHm
         qRHZ39C09ROwPb3RRuRwcJwzmzDVpSNy/1Sioy8XXHhLguPn/V2zdiWzBcBjBErorOzG
         GCvg==
X-Gm-Message-State: APjAAAV+k6OmzSJs3ndIBsKgPqcp8lOB3jErXf2yJpexq0TdeUCAu1gI
        2Lp3NxCcfeiCys3b/2hpBO2Ibw==
X-Google-Smtp-Source: APXvYqwL6D3va6L8LX1+1Dv3WMChB9XhaBWfqtbwCdmmWieTM6HdUeLgnR1XDrodBdQUFzfosXLTOg==
X-Received: by 2002:a63:3383:: with SMTP id z125mr2225544pgz.265.1582568022843;
        Mon, 24 Feb 2020 10:13:42 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 144sm14151771pfc.45.2020.02.24.10.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 10:13:42 -0800 (PST)
Subject: Re: [PATCH 00/19 V4] nvme-rdma/nvmet-rdma: Add metadata/T10-PI
 support
To:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, linux-rdma@vger.kernel.org, kbusch@kernel.org,
        hch@lst.de, martin.petersen@oracle.com
Cc:     axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, idanb@mellanox.com,
        James Smart <jsmart2021@gmail.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <ea618986-6a9a-d1d6-cec4-19c1488bf7be@broadcom.com>
Date:   Mon, 24 Feb 2020 10:13:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/24/2020 8:45 AM, Max Gurtovoy wrote:
> Hello Sagi, Christoph, Keith, Martin and Co
>
> This patchset adds metadata (T10-PI) support for NVMeoF/RDMA host side and
> target side, using signature verbs API. This set starts with a few preparation
> commits to the NVMe host core layer. It continues with NVMeoF/RDMA host
> implementation + few preparation commits to the RDMA/rw API and to NVMe target
> core layer. The patchset ends with NVMeoF/RDMA target implementation.
>
> Configuration:
> Host:
>   - nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
>
> Target:
>   - echo 1 > /config/nvmet/subsystems/${NAME}/attr_pi_enable
>   - echo 1 > /config/nvmet/ports/${PORT_NUM}/param_pi_enable
>
> The code was tested using Mellanox's ConnectX-4/ConnectX-5 HCAs.
> This series applies on top of nvme_5.7 branch cleanly.
>
> Changes from v3:
>   - Added Reviewed-by signatures
>   - New RDMA/rw patch (Patch 17/19)
>   - Add mdts setting op for controllers (Patches 14/19, 18/19)
>   - Rename NVME_NS_DIX_SUPPORTED to NVME_NS_MD_HOST_SUPPORTED and
>     NVME_NS_DIF_SUPPORTED to NVME_NS_MD_CTRL_SUPPORTED (Patch 01/19)
>   - Split "nvme: Introduce namespace features flag" patch (patch 02/19)
>   - Rename nvmet_rdma_set_diff_domain to nvmet_rdma_set_sig_domain
>     and nvme_rdma_set_diff_domain to nvme_rdma_set_sig_domain
>     (Patches 08/19, 19/19)
>   - Remove ns parameter from nvme_rdma_set_sig_domain/nvmet_rdma_set_sig_domain
>     functions (patch 08/19, 19/19)
>   - Rebase over nvme-5.7 branch
>
> Changes from v2:
>   - Convert the virtual start sector (which passed to bip_set_seed function)
>     to be in integrity interval units (Patch 14/15)
>   - Clarify some commit messages
>
> Changes from v1:
>   - Added Reviewed-by signatures
>   - Added namespace features flag (Patch 01/15)
>   - Remove nvme_ns_has_pi function (Patch 01/15)
>   - Added has_pi field to struct nvme_request (Patch 01/15)
>   - Subject change for patch 02/15
>   - Fix comment for PCI metadata (Patch 03/15)
>   - Rebase over "nvme: Avoid preallocating big SGL for data" patchset
>   - Introduce NVME_INLINE_PROT_SG_CNT flag (Patch 05/15)
>   - Introduce nvme_rdma_sgl structure (Patch 06/15)
>   - Remove first_sgl pointer from struct nvme_rdma_request (Patch 06/15)
>   - Split nvme-rdma patches (Patches 06/15, 07/15)
>   - Rename is_protected to use_pi (Patch 07/15)
>   - Refactor nvme_rdma_get_max_fr_pages function (Patch 07/15)
>   - Added ifdef CONFIG_BLK_DEV_INTEGRITY (Patches 07/15, 09/15, 13/15,
>     14/15, 15/15)
>   - Added port configfs pi_enable (Patch 14/15)
>
> Israel Rukshin (13):
>    nvme: Introduce namespace features flag
>    nvme: Add has_pi field to the nvme_req structure
>    nvme-fabrics: Allow user enabling metadata/T10-PI support
>    nvme: Introduce NVME_INLINE_PROT_SG_CNT
>    nvme-rdma: Introduce nvme_rdma_sgl structure
>    nvmet: Prepare metadata request
>    nvmet: Add metadata characteristics for a namespace
>    nvmet: Rename nvmet_rw_len to nvmet_rw_data_len
>    nvmet: Rename nvmet_check_data_len to nvmet_check_transfer_len
>    nvme: Add Metadata Capabilities enumerations
>    nvmet: Add metadata/T10-PI support
>    nvmet: Add metadata support for block devices
>    nvmet-rdma: Add metadata/T10-PI support
>
> Max Gurtovoy (6):
>    nvme: Enforce extended LBA format for fabrics metadata
>    nvme: Introduce max_integrity_segments ctrl attribute
>    nvme-rdma: Add metadata/T10-PI support
>    nvmet: Add mdts setting op for controllers
>    RDMA/rw: Expose maximal page list for a device per 1 MR
>    nvmet-rdma: Implement set_mdts controller op
>
>   drivers/infiniband/core/rw.c      |  14 +-
>   drivers/nvme/host/core.c          |  76 +++++---
>   drivers/nvme/host/fabrics.c       |  11 ++
>   drivers/nvme/host/fabrics.h       |   3 +
>   drivers/nvme/host/nvme.h          |   9 +-
>   drivers/nvme/host/pci.c           |   7 +
>   drivers/nvme/host/rdma.c          | 367 +++++++++++++++++++++++++++++++++-----
>   drivers/nvme/target/admin-cmd.c   |  41 +++--
>   drivers/nvme/target/configfs.c    |  61 +++++++
>   drivers/nvme/target/core.c        |  54 ++++--
>   drivers/nvme/target/discovery.c   |   8 +-
>   drivers/nvme/target/fabrics-cmd.c |  19 +-
>   drivers/nvme/target/io-cmd-bdev.c | 113 +++++++++++-
>   drivers/nvme/target/io-cmd-file.c |   6 +-
>   drivers/nvme/target/nvmet.h       |  39 +++-
>   drivers/nvme/target/rdma.c        | 252 ++++++++++++++++++++++++--
>   include/linux/nvme.h              |   2 +
>   include/rdma/rw.h                 |   1 +
>   18 files changed, 955 insertions(+), 128 deletions(-)
>

I found the first 6 patches confusing and in some cases unnecessary. 
They also missed some things. I've been working on a different set that 
I'll post shortly. I had hoped to get these back to you sooner for review.

-- james

