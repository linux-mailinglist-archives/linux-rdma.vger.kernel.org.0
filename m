Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22682FB17D
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 07:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbhASG2A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 01:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729958AbhASG1v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 01:27:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7ADF2311E;
        Tue, 19 Jan 2021 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611037629;
        bh=iKmToiKodFHLE1LID0tkV91rVaT4TB4Ad9Z/i1TbRrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFman+L281479wLDTEzGsG3P0pNziiP8Lg+OOLUjKFYPNeSIDkJ7EnLMtcFXIa5KR
         Yhg8pbsndeH3QSaBAYbaR4NvQsAEqY1w7x08RWHkla0ZzWGysmydE099NmPwLvl24s
         jGJZgbMFephopel8zBAaJFFNZXdbt+NiXiGRFnQUzVoBAazt9v/WHZPHFmTJ0O35/y
         WlmYhKM5ziSPijjPKnq+atRZM6+vCmKrTELIKabH+4QJJ+IFgiNpGLHHCsFCqup7Jj
         uCEtWvkonYIbOQoWuv60M/kHqpeiVMVExeKqZIzuhVw0gncHHblsNOgEGElB3BSRpa
         EoUQ9NOECNriA==
Date:   Tue, 19 Jan 2021 08:27:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [Linuxarm] Re: [PATCH v2 for-next] RDMA/hns: Add caps flag for
 UD inline of userspace
Message-ID: <20210119062705.GE21258@unreal>
References: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
 <20210118200854.GA778611@nvidia.com>
 <180c1cd8489e430eaa99913885356e03@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180c1cd8489e430eaa99913885356e03@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 05:53:40AM +0000, liweihang wrote:
> On 2021/1/19 4:09, Jason Gunthorpe wrote:
> > On Tue, Jan 05, 2021 at 04:47:03PM +0800, Weihang Li wrote:
> >> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> >> index 90b739d..79dba94 100644
> >> +++ b/include/uapi/rdma/hns-abi.h
> >> @@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
> >>  	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
> >>  	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
> >>  	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
> >> +	HNS_ROCE_QP_CAP_UD_SQ_INL = 1 << 3,
> >>  };
> >
> > Where are the rdma-core patches to support this bit? I don't see them
> > on github?
> >
> > Jason
>
> I thought we needed to send the userspace part after the kernel part
> was merged. I sent the rdma-core patches just now:
>
> https://github.com/linux-rdma/rdma-core/pull/934

After kernel part will be accessed, you will need to update the patch
https://github.com/linux-rdma/rdma-core/pull/934/commits/2877713e1fed29305d04e39dd934ea81082e616e
with the correct SHA-1.

Thanks

>
> Thank you
> Weihang
>
>
>
> > _______________________________________________
> > Linuxarm mailing list -- linuxarm@openeuler.org
> > To unsubscribe send an email to linuxarm-leave@openeuler.org
> >
>
