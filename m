Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A4C277C35
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 01:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIXXL3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 19:11:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15191 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgIXXL3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 19:11:29 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6d27930005>; Thu, 24 Sep 2020 16:11:15 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 23:11:18 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 23:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqhLcjocJNZl94QCHyFfQuFAYlA+aD97KMtHhnbK/EYYN/Tyvt886Cc/jT9z5bVikfycbb+kuKYwzzmRKkePDtdmTHPJlyKlVQLNUylNrXebaHdIzP//+fuXt9XrmN105ybHzcZ/LAWa/X4Q+ZO2ESiL21QJ5/UThvpG/FND/aBYDZNiOvxtauC3Fr/wfWWydvhLe5lpFfzCJp/ylJdRu4NNapNqIMChUv54wmEZf7sVPvozdB0cV2jMvEbPpViWwvGkIV4ZwDmmXehND3Stm4dDzTZm8lzkBMO3yl9USd+ja1Mh6HtYmr3+AVJRhecsaTQqSDxxBtIf/YfaBFAV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP9XrWt7eaIkVVpH1pNaMv9fnNxAsgCLjEwRbdrRP1w=;
 b=eMXY5IBA9qCNXFOID3UFlyK18buVR2Nq+0znvoO56FptJMg1eCs83C4SNDTbpG4JoIjZb+upqmEKXuR6ZOVeT8JEJCB7471dg73AbadO3OZWibD/u/bn2tVVm46wiP7vtP5hvv6jCKhHLwBjYTg0Qwuf0yocVOGQrI22nY3aLyWC+ij28KvGeWSaQVaN7RbBGuaZWDbv4u5Vy0vYhV3EYZ7ruSBNK5qi/LSwJtjO2x99FRw7ws+yiqdwCg1soBGIcl/Xjvq6ZIXYwYChPwg6R21Tm0AJxZeJ704VPqRCO17eQvjcmx/2pAdOr4mZOJLmuD4gkVMgCVNoFiTjT3A9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 24 Sep
 2020 23:11:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 23:11:16 +0000
Date:   Thu, 24 Sep 2020 20:11:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 08/10] RDMA/drivers: Remove udata check from
 special QP
Message-ID: <20200924231114.GC154642@nvidia.com>
References: <20200910140046.1306341-1-leon@kernel.org>
 <20200910140046.1306341-9-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910140046.1306341-9-leon@kernel.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: BL0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:208:2d::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:208:2d::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 23:11:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLaOQ-000eFy-Th; Thu, 24 Sep 2020 20:11:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dda56b9-3a56-4085-c3e3-08d860df237a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB248750EAA26AA626BCB7D331C2390@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsaZafQS/i/7DgN/AGLZw2BVle4sQiUYLeXNYogCMpuxKlBx0HRtAfrVkoOqYgt6Ikv1rnhcinhr5nt/80xzynuz0XjXmZIK2mRESp2totf6KWPxeeHphNi6Szc9QUJlwRApUrpC/B73fc3DZOzB44TS8tawk2jBv6oDyCvmVAU47hchsOTiPBWAIGKdIFTXDNt7KWwWC2u/XpwBU+RDeA2DPkOt6XomQlxiH8S6ZLGONyzQmSuJayx5XfgWp+N8ii7iHUicNH1pfzTqZ1m2Hkf85TPmUKAlHhNzRuvv4uQQCkgzUHfDFXBozgzjiAFjszlJtDWpS9OAw9oLSVA/sa2utAm0nCwtEr8RHGc5kNtZ1I72J7N27M9GR9KkG8Fi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(54906003)(2906002)(316002)(4326008)(86362001)(107886003)(426003)(5660300002)(66556008)(66476007)(2616005)(1076003)(478600001)(8936002)(9786002)(36756003)(186003)(9746002)(66946007)(8676002)(33656002)(7416002)(26005)(558084003)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: b9E8Iz0i/TJnVVQh467OFuC3tOaigqfIUK6E378hJNmOiUJ0wRrv5pA3VZN07fMTpPfUpMjRFpBsO5ovtNM2+UcBHu8uTYAkdcGvo4Ty4r77QaFIcLuLYZALyIMVmfXvvdiBWHDRuRn4caQPRYqmCAmYg5X5a/bbglNrwOj60mZGm1zeMj372Sk9+uG5GbAadwsMzlbb3mYX9x9Wf37HW0TpHfSOIutOpSesVkzb1qEsmXdfeTrN4tN8x5WBGbJfumef7COueyl8KI75bZ30T1OTerhQoXqwblULRobEONZNWYv8BKHSDU80H4H1PbbKq9cYGlLHLedlYGCz7koRkoEcV5IGXLHk2b2ODyreb46Pyd8xAA62yEQlQ7ddocSjxZB9L45XH+KKEIsK6pJmVc7dcHKULJmFXysG53+weDYM2c64bOB9KrMI5KPXxPdOdmg0qRNZwKQJMwpbV1vopn/RAwp2ue8hWSK+Y9koi9LN9FfLMZJ0Ju9SYfACSzjzKfcA1oGuGdKyw1Lpr02Bzq7lE5NKZXO+Fhwu7tAVileQmehzH+1/Bq31txCCUOPIPCQbV1a0pIwVOUs/YbSROtBY8TnVSq65y3mv7//M4uNVFk7Fdd/JxwZL9IAj+U9TqVNHVstBo738TpMj+IGpmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dda56b9-3a56-4085-c3e3-08d860df237a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 23:11:16.4435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M43d0lBMv6cYsv0v6M3fDoIOgU40qn63d7fxavYHuucC1QB9I09DzVjxcvIMDBd2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600989075; bh=dP9XrWt7eaIkVVpH1pNaMv9fnNxAsgCLjEwRbdrRP1w=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=nQq71coWPd+rkNSaXSlgQa2M88lIW4ppAekKLS2F6kORd3DshPFlMg6M2PSEGCwyx
         z1gsW6KKMYtJflAiQgo+YgxRmOw8O4Nmja6lGoYSwdDS1oyzDiShl5zVC8T3wNH1Or
         5sEFdRItyMVz299BUKd/TAeh+MUACM0zF2Vk1az4OKAXw2jd7SKJLlLwJnRPgCSdOj
         aoN/COayM2mnHoUPitlmWPZPvq6fUUsVWgigXcHRbpllol/fDt/NVcsl9eB0EcfE3H
         FlGPSq766bPTOLMZUlvwDxwxEI3b2kr2ZnDgjLuGe4letg5lHlIH/jFor6NacuBZRC
         KRfk6WJ3Rg4OA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 05:00:44PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> GSI QP can't be created from the user space, hence the udata check is
> always true (udata == NULL). Remove that check and simplify the flow.

Most of the cases are 'always false'

Jason
