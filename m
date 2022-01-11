Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7848BB6B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 00:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbiAKXaA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 18:30:00 -0500
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:59648
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233873AbiAKXaA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 18:30:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfAE7SkRMUnhG1wQp4imOb6a6ZlsS8hrKJAmt5mkEbrqo63NfytnqpNNQEwjWhz8lEKcygAfpAdumnGqfHWYf77yiNwS1VmVTACSZi1My+L69ruscSaXzKbZL9OjVGLpvdZDQO/JNyPoAyh0bufRrgq7lm1jSNsm6JPai8zWv4J8izi07Ha4ZbdaP3NyfyYPxfzH6RDuhvNNDahyTgYIz5nUjD81URknm4tODTGBQ0nJ013yDm982zGT073VwwxcCaIl81tijdW/n8/cIiTFfcoR0EYgca/ETeXRNJr4pYZ5Negrw1jl98k9JgaoW1StJp8dF/ZOh64YBdf1OdGpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT5DPXqMf1yDIH9TJWHgjm9ADusuzMlN2zaTuluydds=;
 b=VGp3PyrDQvGB4Z4wVk/qIR+VRsFwqiF9fY+bxUoJ3FQ7H8Kjmf9yD2NSmsD4aLd2VOiH4johzg9/t8nBSIIE/f5eFzPj56IlF0aIwBNNihympo5TI4IP+r1k8ngbyE+O7wAz1w8gYprtHNPGoQbIUre0cGCa92EWTRuD2YC8fCcDxfrepybHlQgEn/AleyqP3PXLI2qQdVEAJqcIuOz2mFfKMZYJn5ZOutOQVQUelx/FuWvTzz/kT+gQXz2XXGidUB775/BcXHAHWlEgPV+wCf97DhtViZl1Niq226RybE7zu/4sLtG/wTd3/6AJ8rTC9xBr09LNlsOCzkZqtzYirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT5DPXqMf1yDIH9TJWHgjm9ADusuzMlN2zaTuluydds=;
 b=q3p5yh3X2Iz1ZcjDkLbVHTt8vieH5sUnb7sIDcTFCsMyYTJ0GRE2oEMPzx4C549GNZNaAwHZngMlw0tn+NSh4xAuVoN9ytJkVtts0MY7Q5/8RdV/8M0rXiihTfMlZdGYbgbiDYnGPfXnYZNSlQzY/wF/7+uUQfnD5sBNT2sRgZQOz1G5V3TNycSD2GEvXWO55NVFoXcacQkbudCw6pGIHEgr1nl02+S2K59AKsBQLHrlcpg1pP+856D7MqXJud21BGB8MH9iEfCUnTqUDfvhoj8weSEKSPDfCAkWqnKYcmq+CWHfXSLpldxG10TYElQKEMBC+7niCrF0DyT7l5+Fag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 23:29:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 23:29:57 +0000
Date:   Tue, 11 Jan 2022 19:29:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Tom Talpey <tom@talpey.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220111232954.GU2328285@nvidia.com>
References: <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com>
 <61D4131D.5070700@fujitsu.com>
 <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
 <61D4EDB6.7040504@fujitsu.com>
 <20220106000153.GW2328285@nvidia.com>
 <61D64BD5.9020401@fujitsu.com>
 <20220110154205.GD2328285@nvidia.com>
 <61DCECAF.10206@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61DCECAF.10206@fujitsu.com>
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb902429-900a-47c8-f47c-08d9d55a47a6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5271857DF3B3462BEFC60FD2C2519@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHc7+nmoHW6Sczlls7E/SDT5eRqqWthjrOvsHs+V7Vx2hrLCveUNyBCZThxshoPumjMamWqxVHYgsAzihP70k0bOGHBhuIJvK9IXdtANoPuLmkiEcYDQ51YTPKn5oPfAeJZYqHlue4Oqz7tNFB3+m2tQFYz2kEHGHiHyxWB0M4WaiZZWSt9XceKyqJJIwLvbaK18LVZiC57ImyWZDHsL9srEKlyer5wMWqnFc7ddl8lPd+g0Mx4zBevdqzC5kUbTb7na7QBx4HKBx4gl/EHKnEyEu/+kgXmCAV2nY+Pt0XGGHwr37Mz7gMv0lqgwRtvGD6bpmrlqu3P81Lct8dTO0h/NF7Lx05lXl0/7LBbExSDpohWfGMGVWNbBrn40brcrIxBRRiikPCs100mXCOdVy1EhH9JfPKhIwE04X9igAbh0Ydjx/WltH6z8FWyc5Uap70VVG/XUffgpJd8URJKdBI6UhdCDS1fR0TyT6CSZ32IYEt/kq964OLHewJwDVjnIRFjON6e1JAc1wD1oneSDbCyA99Cr7bMl0AvZRwdSW2G9DTvLx8SNjbhCnjWe9x2oNeRiOhehaLa2KH2YXtpkAbDDcS0wnMG5gHRNtZ/1j8rxK5Pw8Pd411bhn8ritxY4Akc4v/U4fLgX3Ftcv9wThg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(54906003)(4326008)(6486002)(1076003)(508600001)(6666004)(8936002)(66946007)(86362001)(5660300002)(186003)(2906002)(66476007)(6506007)(4744005)(66556008)(26005)(8676002)(33656002)(2616005)(83380400001)(316002)(6512007)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LdMrheogADGhuMNbYoiyQZzdIkElVu3LPIymxkR5OuNx9/Oavx8QS7Sv0xO?=
 =?us-ascii?Q?snZRgwMhQTPzT/mEZyA4CFfUt4V4nndHBE1+NR+8ht3YyF2BOuYOiwCDb3Ja?=
 =?us-ascii?Q?7MNbElimRCg8HY8lEL7Szgo2I60Rv9K/mVljtqm9KmkgYKX5oAhmp3hvYm09?=
 =?us-ascii?Q?tN3L5umFavyTQKawAEpeYa+A4IR+Ipw2Vp01heZ4IBuZFupr6JAIohLJLc5H?=
 =?us-ascii?Q?XNpEGV1Bjz/poRidzkgEuX3IDyN+kPix7/hJyPp1ryEJ27eaZ1siAnCB7VPS?=
 =?us-ascii?Q?FMH+3ArBo4OPY31gMdUTbKT8hYVFU0zlAq25HylYbbzgg1K0FNzvKAIAU7AE?=
 =?us-ascii?Q?tEBMUPdLYg94ec4H/sOqjtsddEzzVtT6SBFdo6la0BC8AY4dn2Al3nV0Ioil?=
 =?us-ascii?Q?iZHeu1qE2S5PEpjZRP3VTrMIic28dUlYrf0sLvTuj43a9V8WJ03yDlj1Eg4B?=
 =?us-ascii?Q?d3+LfAcA6mVeerHIgyA7fK45tEv3YJClC0ddGBwORogV4HSda6bPKlf5eCSO?=
 =?us-ascii?Q?Zsv+oULFmVz3dZswBXJEy4gvRszuoVkyp9l4d8Iy29FiiLbon0XDzooijZzo?=
 =?us-ascii?Q?BJvMZrfrtGCBRE3YnwosX6qrSDnLCXjdFNfP3q37w0/izz5odMer4HIKoeVq?=
 =?us-ascii?Q?vUPg82tpMd1IS8kmUm3oRTWAIV+T1ok8L2R2OOfudvVmYJJE7di0kdz3lYr0?=
 =?us-ascii?Q?wUn4lYc1LODq8jEC+CzytXioQ3/xAnW54OcELgtdrlM57IdGxWym3SKef7Ru?=
 =?us-ascii?Q?+X/q0SzfeAbyP/NzJZ+V913oyw2+bMItGAd4B754ibudlKSBI6fwuMwGu9R5?=
 =?us-ascii?Q?4+bv3243PnHcrnmoq4aKq+WUiv0uSVB6qXo8ol0hZ6xjQihqMqhmzi/f9mX4?=
 =?us-ascii?Q?jG3Gaw0wPpN/IcPJx+OgjEAJm58jQbpZUGj6RcFBv67S54g1MVxvi/6BMlx4?=
 =?us-ascii?Q?SSHW9DMAeQyO0suCR34EzdIx6/8OXxFJ6J852Oet8fIG80Q5/JxSR7T5L8I1?=
 =?us-ascii?Q?BatasrwNa1SLChZhoS907tbZPSkpHpS5dtg3smHJt0Sv+nYhKSP/72beQQdI?=
 =?us-ascii?Q?U7P7eNrc6bZlWSxFnOYixFgJJULpgbzovVSbKE/GKDWT1CX8bn8XMX+fy4VO?=
 =?us-ascii?Q?GsHxONNkIO/565B+XsUToP4oNpOxolzQ31LCJ/sO+OVL74VyChsikBC3fgEx?=
 =?us-ascii?Q?aI88khhpSt8xUfTeuJm+Egi/WvaUWSnpEJ0Tm39LM0YSPM+JStrsbyn2R1MI?=
 =?us-ascii?Q?3uo4UbKCqD2KzQaHlvBf4YZoWV36lB10QAGsJM21eLHGfr9jgEt4RO9vdzz1?=
 =?us-ascii?Q?1GDk/yezWmsrxnJMjRNcr2RGoYujKH8x2+gBhvprCGxRdkxl/8JJKhvJVWCF?=
 =?us-ascii?Q?zx8UhCvs2tNTQnVdwqMvRKd0tsezhd5khUo+EDlxupIYBgjHAFEkyMxcSZ/X?=
 =?us-ascii?Q?+DQVsXbcTQjPj21Ottp9kBVOc66YAVzwslsVhNp4jbGLh4jknDZL3tUIkpWL?=
 =?us-ascii?Q?Qx00/Qn5GFU2lnc7ANRIUtvR73gMbcPECjUkQAnBuDOweJ8QK/oHz4FoFz7z?=
 =?us-ascii?Q?abGHBr0nCpay/qWuxAc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb902429-900a-47c8-f47c-08d9d55a47a6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 23:29:57.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0G0K1fY0AQn1Mf/RPpj5yrtK56TzIHA5T5ItBySA6vicM/2EDnh7/sM4Ebm5hGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 11, 2022 at 02:34:51AM +0000, yangx.jy@fujitsu.com wrote:

> struct rxe_send_wr {
>      ...
>          struct {
>              __aligned_u64 remote_addr;
>              __u32   rkey;
>              __u32   reserved;
> +          __aligned_u64 atomic_wr;
>          } rdma;
>      ...
> }
> If it is also wrong, how to extend struct rdma?

I think that coudl be OK, you need to confirm that the size of
rxe_send_wr didn't change

Jason
