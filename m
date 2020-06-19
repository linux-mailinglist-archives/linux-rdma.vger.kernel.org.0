Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6911FFF3A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 02:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgFSA0g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 20:26:36 -0400
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:6093
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbgFSA0f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 20:26:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ6otGPpn0dLj9n3g17Xzs3fgHj1BV6YWIBbzucBTyqTyNO384+nVlTRvBrakHVY50+pym8253wAG7P1TxFMVCjneajST61iyKTy8ciycDZ2q7uG6/X0J/yDAX/o2NfZGWXDGWssq6fBXbU2pJeytCbMvmoja7X2/yiLu0ygc8+z9f1NUkEensLimTYsHmHJU8ANNksNUPZSS1SPkXySvLW9OkLquGA5uYQSVmJBffiVJQlPkXK7y1o7D5KADXtktmXPk2XBOCsEsNbzLIAIgSdIVVRBDnAox44aCphMgyJIp9hiGzY0cn2+K/jW+liDfzNjKWH7M4Vxp9r5bdIvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eydPPXiGoVD2HdVBVKHI1O0+aSmnMp0uQ9pft9bEF5Q=;
 b=j0/Q5B1YPWwxukJoJnj55Zhs7+542QjRSUuJR9jchoU3h3nWYkLiRl8NCUF7ZAGJSrQ7jzW3/klPGqM+wxY7kKb0fdGhg+KncdkQn2Clz4VM8qKh7TAMckrFNSAP7YPKxUufUBk4Hn5TvX09/BFi1hRgBj+NO33QnzPHdoZiuDNnhjPriXjP+KrRKf4dxFiy0pRsx68iHugVSNP4LBd8QsImIznqknXSl1pea/gQiZTHxdkSTCNnfWDQgFYRyIfO/GzrahMRYO5JBuOfguovsWN0gPk158NAaOvjZKkRd2U5h4STYT8mvHKVn7C1OuD334C1XVAEOTXoDjOQ/tZ3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eydPPXiGoVD2HdVBVKHI1O0+aSmnMp0uQ9pft9bEF5Q=;
 b=eWxBvC+MFsiCSZBgfkCLjXYzheo2mNxedjNnQ/gCFjS+ylmiF6oBoz1trZT1zgFVOem2msrInCO7jX2DWcEUGeq5GKXL5h1zRL4HRkG4B9U6TfJ0aY3PdF/ve6KfGEfUT5UggVJI0uFImh8dq2HUrrXVZTPcS64DatJ4DPygYvI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4879.eurprd05.prod.outlook.com (2603:10a6:803:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 00:26:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 00:26:31 +0000
Date:   Thu, 18 Jun 2020 21:26:27 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ariel Elior <ariel.elior@marvell.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH stable] RDMA/qedr: qedr_iw_load_qp() can be static
Message-ID: <20200619002627.GM65026@mellanox.com>
References: <202006130434.950ZY2zY%lkp@intel.com>
 <20200612201903.GA57396@0a3611e7790e>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612201903.GA57396@0a3611e7790e>
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.11 via Frontend Transport; Fri, 19 Jun 2020 00:26:30 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jm4rT-00AbV7-5X; Thu, 18 Jun 2020 21:26:27 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e20fd05-8c5c-4268-febe-08d813e769ef
X-MS-TrafficTypeDiagnostic: VI1PR05MB4879:
X-Microsoft-Antispam-PRVS: <VI1PR05MB48797C2CB0B0C528774155A6CF980@VI1PR05MB4879.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfHi001WnF9vrY5t8ijqkcaPvhe2PN2U223nWMPtQTXeKINwska3KhR8uJbvv+2MESREf9NPQVp2lM8SAkAmzH3e32xjj1Q3JLHg/OFP/UzQCzlHEI5CmOlNjvgpjDs4dKJMlFnG2rDAmLIhfb0bkFYVVPqK3K5N/2eLo76kvLzynBdsUaSwS5WXbwFA72m5DyI8mEmrK382BFXWs7f2niMnyrYmkSoVF8js3GYJGhPnvbGvIlLsMhlnd/SQExuAd90dZbEECYqGsEI2ezcZcsiOT3sUzUYnXXPBPnfE+sVLFLkItj09W2Qe3sSHfyunme5hSyfc/CC7KhC9cuPjag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(4744005)(83380400001)(426003)(478600001)(66946007)(5660300002)(66556008)(316002)(66476007)(86362001)(9746002)(9786002)(186003)(26005)(4326008)(8676002)(33656002)(2906002)(36756003)(6916009)(54906003)(2616005)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fe8Ct+sIutrYiDiPqP1GD6UZfkfZIhourofx8XBUneEUpDCJaQH1/dhcc3gdPh2iuyhVaAyRbaYIVtRQ5ZvKn/+eWD93jk2A+KG2AsTOILYq00pkcWvZkkXYluY6i06pouiPXW+xuwcJfnJArs9765DctIVdMxrzcHLryYt+LbsmUGfnX4R1bvmKPIzcdq0cXMamkT4bjBjZQsetaQk1KT90QrOhT5OgSypYmo3Zwo1tLFk62Uv2vuLRj15Pxn2K5S5/mUe4VkGOT9tvjn/5SJSVycc7RMXsFnmj537z9wznPe2uD9ocnN+aJ7bhDyk/Bb2ffVLUy5IcXfW9AOnZcTnyTT+CbruYbwQjf0a3rvxYabGvCGCvIUPPksGdKKfcyrFgxXKsBMVIyLAzaxx18rLDZkodplx2Nj9tx9TsC6TABZa1RnrrXwXfhRvAbDsDCQagLgkvb2REAFGuloF+lzPV9pPzjUvKH26UovAIdYY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e20fd05-8c5c-4268-febe-08d813e769ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 00:26:31.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF/Uhv5qUHn8imxPKHJXP0x/hwiDxF36QQJNtkJ3V3DLAhPPz74qA4pDCr3SvNgQUJ/GBWnA9yTWVENBJvxJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4879
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 13, 2020 at 04:19:03AM +0800, kernel test robot wrote:
> 
> Fixes: 8a69220b659c ("RDMA/qedr: Fix synchronization methods and memory leaks in qedr")
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  qedr_iw_cm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What is this report??

commit 9a5407d74c22821f7944e2be4209bdfc5faf8143
Author: Kamal Heib <kamalheib1@gmail.com>
Date:   Sun Nov 10 13:36:45 2019 +0200

    RDMA/qedr: Make qedr_iw_load_qp() static
    
    The function qedr_iw_load_qp() is only used in qedr_iw_cm.c


Jason
