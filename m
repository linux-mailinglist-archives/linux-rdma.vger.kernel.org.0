Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF43144D3
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 01:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhBIAYj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 19:24:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6126 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBIAYh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 19:24:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021d61c0001>; Mon, 08 Feb 2021 16:23:56 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:23:56 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:23:53 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 00:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIAB4wIHPZ8zxXRxXVGerrpGahKRaurn4CYiHvnGpLZ244m8Xt3pCQbr/r/HAwH8a8C4uP8ILBd/lvhAfokYaCTXcsTgUhn2D5hVPiOpq7ZDrDPpJQCPK037Cu7LQykOjAfGyso7eOsubIDZt5mE+lJ0ycFwasUtIVg54qJ7clcu6444cmCwYKO1hDCi6ZMralHyyxIVOD0rTK2S0HyaEeIHzyo/qFejHcuhpsC5qi4ea4jDcYfS3lkiYphrXasyFLr6vAiCh7Yyl6CUJkefaXm8ekPU5PQnAEzzr/EG8yUWp/N4p5yQjdB55fiT9kAyv52VG3EQWm7n6W/uMgyVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrNGlBGwYt6/DssUd6D6/xriMvo6M2vspmA9u6Wx/NU=;
 b=L2uo0sW2S/PTTHZR5HmPdKOF5E9fWsaorAQfBOQH9Klkm5NJgRvkwEa1D1IKdGz1PPUyugVH43cf724ZFHeNwdmdqAwY6ZfPUE0bFTBc24AOPS9RlwoJL7mQLv6KIMRo52XspP/KW85MGGyIGJkR3mA6lqdKCd4lQ4mKctQKw9Rt1gxws291uijGLVDL6RRdTTHJS1nkkIWGBelrN+Pw6zNYSuaCb5I1EUvPeu4kk0eRbjyDhVvmW8hLeT+0qecOk4VxrZywB0nYZvSO7O+pkeE2ZQjxInZZSzvZS4iX+Y+BaOyGPPHYbrcMpzaNzZYrzwodUqL4qtJ5WEyL9+i+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Tue, 9 Feb
 2021 00:23:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:23:51 +0000
Date:   Mon, 8 Feb 2021 20:23:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 05/12] RDMA/hns: Adjust definition of FRMR fields
Message-ID: <20210209002327.GA1233507@nvidia.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
 <1612517974-31867-6-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612517974-31867-6-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:256::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.10 via Frontend Transport; Tue, 9 Feb 2021 00:23:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9GoR-005AuT-Mq; Mon, 08 Feb 2021 20:23:27 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612830236; bh=lrNGlBGwYt6/DssUd6D6/xriMvo6M2vspmA9u6Wx/NU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=e6/iaPllDBRx4yzPtuvY0h7qh+jOy/yQIibPBA/AoVA5ngUjzNQPGs2F5zdncPoBi
         tlCGSjSHA8AocBguEm1yC6u9IRlSluQ9+iuSSW/za4wHQLSEQM43p8Yc1WO/LjCAoJ
         1wlAXRYOFcj5c6KbpySlPa1zQw4Mc6pStAXNa7LprKLQcO/x8Vh49PYNfWs2+E6dKn
         zu6AERbaPe/fhdUzZC3djVjKXFalicSse4+zfzIrWHnY3QxhdCcWMMIM6YqmW/qUAl
         hrianXkbze0aOfNjBbfAA8NzODaxg43bZFG5ULVhkOMXnW89MijJ4Vo0E/3qNaHg56
         nukhPbAcs0/cw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 05:39:27PM +0800, Weihang Li wrote:
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index f29438c..1da980c 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -1255,15 +1255,15 @@ struct hns_roce_v2_rc_send_wqe {
>  
>  #define V2_RC_SEND_WQE_BYTE_4_INLINE_S 12
>  
> -#define V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S 19
> +#define V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S 10
>  
> -#define V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S 20
> +#define V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S 11
>  
> -#define V2_RC_FRMR_WQE_BYTE_4_RR_S 21
> +#define V2_RC_FRMR_WQE_BYTE_40_RR_S 12
>  
> -#define V2_RC_FRMR_WQE_BYTE_4_RW_S 22
> +#define V2_RC_FRMR_WQE_BYTE_40_RW_S 13
>  
> -#define V2_RC_FRMR_WQE_BYTE_4_LW_S 23
> +#define V2_RC_FRMR_WQE_BYTE_40_LW_S 14
>  
>  #define V2_RC_SEND_WQE_BYTE_4_FLAG_S 31
>  
> @@ -1280,7 +1280,7 @@ struct hns_roce_v2_rc_send_wqe {
>  
>  struct hns_roce_wqe_frmr_seg {
>  	__le32	pbl_size;
> -	__le32	mode_buf_pg_sz;
> +	__le32	byte_40;
>  };

This stuff is HW API isn't it?

I didn't see anything to negotiate compatability with existing HW?
What happens if the kernel is updated and run on old HW/FW?

If you tightly couple you still need to check and refuse to load the
driver.

Jason
