Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919A0342667
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 20:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSTpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 15:45:03 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:62304
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230090AbhCSTos (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 15:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGGOhpsGa72MF50u2BqD5RzhoKP5985Xn0WBqtarJGoZpULhYxGNiJ5bw0U7kXMrB7bpOZ77yZ9xC9sRRTiWdHmLrQ6Q+iXfAMYrv/24LoqPqYBokGuWPmGsHJnfJuuoN+EtbwEOa/MIqgCVHETfxX21W6xsBStjXLhirdlvayEM4mr3Sw6Y15rYAKScVnlZ041OAcZ6ou8UsxcWLD1wTJyzqdXDKq2PGxa9x2EbqXhtHNcEIwvQpui1zfNx3tssbONOw/Bgax0cy+dMMFfufBz0yOChwTscHIlLAmTOSvGm2i48LurtImWzAzfmAUUckrBz7+XA2MmsM8lOmy0AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKpVkZyugAqzZufcajms2OI/kQUfBwv2bc7L1g+qwjk=;
 b=fBPNCNSyWQ/AabapukvH51kMPxH7Kf9Ughkb3/J81nqRPILmvwk4hu9k07Dj3sLBsZ9l5YG9xvuwZeJx6p93LX3SBmYi9nNu4s/iID1lpO7BVMbbf9ejGeYY1UXhZfmxBJoQIDP/vW2xDrhhnSlY5BdfAzH4tlRQz3Yg72sQBJ71Fu3yIPiQ6zR2LwELizWzFHvbM4zglPHr36z4TGuthkjgtXThjrc6rmKH84QiOijcT1xaeXmvBTM3dlvT7QKdXJDndxo0uA0k/8YQiwRhpNdURYIwgswCUZKTAEsVDcvbFeOwJTfzQpm4jH+jHyL1pG+CJMwfqmNaEUvXOqYvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKpVkZyugAqzZufcajms2OI/kQUfBwv2bc7L1g+qwjk=;
 b=otAqVJ5V9rg9l4Q9LP3A2HsTr/lrGqTaPJgAR1eaNrzWkaKoYACESnqyqymSXuBog+/pw6j0/iroIKEXhJEQzECZVfZnFkeBWK3sBmgxWbMfc7TelYEuW0zBYRxtNwNFql14cjdJJVFivWm4e8GrJeqq73OiJuUAXWGZiN7t85/b39M8V3cI/Z65FyK9m5igXO/2MYkUYy1TA7JPx9JjMHIro/RAydj/tKn6ogYwtrcZX2WWTIi7mWght3MOUL0JaDRbThkarHSNJyQBka0AcU48KLGIhYNF8RdOlsgeQf8+3umjyqoFMQhqmkwxeii2YF8VU6GEOxYoerHhXKCSXQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 19:44:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 19:44:47 +0000
Date:   Fri, 19 Mar 2021 16:44:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319194446.GA2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:236::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.14 via Frontend Transport; Fri, 19 Mar 2021 19:44:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNL38-00HP7L-8M; Fri, 19 Mar 2021 16:44:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2741d9-7728-425d-d2e1-08d8eb0f73e3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499AE7AA5DCB510A7711381C2689@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TluApzE3Iqec5xa8KYRwltrwyTfvuEt6XVZHeSubIWqLxKmn39f72bo3TjgkHfH9tprcBxLdJWfunbhi32vhBonHEYHGMso48Y6P5wxNQYlLzXDGyQe7yaIPmPc3JpuTUgB7XUkN84OCZ+cJdcswnrR8nARGtlsJNAguljhjTScBobHUVdGBVRenEWagIhhC42uINfqi7aaauc+pZStAkO/ixtlTbRY+iTT31rYuuif+ptLUmuvvryuQsfgiGPZ13vEMsZukke/vDHZnr6zmp4O6/WOj2tVVlNc0MTnMsZ08QyE/TGpDbPVt3hWftRtvi3oev05JMvLEjoeiXqvVE4gyTutobRKKdt5ElcjeZikEDtAnaPMpy0v+sY3c+WT2l3wDqzJXR4we2Tm6uGLpqTnKW9TPZNgrjoOJRRwcFmA8OblxN3Z7jScqSOJvyPZZRxhQxd5MTMdIb9Kr2ITmkhhVta6PI/A1MkMdrFQiLZU8/D9pDJmoIHnxZKELb0+/5MaDEBjccg7Ru/vuGWgjAdf9eJZQ+SdZmq1xF/H/d8Xo5ZjbjBCBsegSKM4uG+axuPYGc5WxOyFdi7X2wkjcUt7p5LVKGqMXxeuQMXc4UnU5FEEWJ9BPyQ2vz9arLEogSlfdM+47GkVHzZPVUwjimP4m/4YXGxUGgGaZBG5b4Hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(186003)(9786002)(5660300002)(9746002)(36756003)(2616005)(8936002)(316002)(1076003)(426003)(2906002)(4326008)(54906003)(478600001)(33656002)(8676002)(26005)(66556008)(66946007)(66476007)(6916009)(86362001)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ilRoeGHSQE5gegddLbWEWV7UYfx2tRG5YGuD8ln9XdZUo1LtOeccWArrVl6e?=
 =?us-ascii?Q?hYeVW3hFSY8kVTlHpK6W5PJp68Mj1CBVkfSqmd92iLf6+FL9KRH3dcfqD2Sx?=
 =?us-ascii?Q?5T1zZbpI4mSJbIAlsYdt5dJu0mT13HjX5pxAWCh7TyYJz/BAXP9qMSmfnjNv?=
 =?us-ascii?Q?vm+yv1bIkUEkidTgTMYU9fISiH0/C0oGbA7opva1P/wlZbF1HlF+21tDgWp5?=
 =?us-ascii?Q?+jGXxg/ibm8rdtxL4L2z162z8fGdm5lzLCzrJ8MpsDnBBrW7gtwqARGV3a4G?=
 =?us-ascii?Q?cWCFgBV7dC09CK5uKS2mI53FR9iFgdD6zYlTaBXXFmv6uob24XRmA6uUN+uK?=
 =?us-ascii?Q?2FXHL/oDWMNM15oNLlLf5oAK7bcORMdIHL34LdbjqD8WAcuEp3GPGcit64wL?=
 =?us-ascii?Q?NHD49mniTyhjLviUYnth72UIb04rOaj2s7gf3ZiJhVR7w1wHqOmhV/ZR0TWI?=
 =?us-ascii?Q?CHNi4Q7lNGQsrcfOvEgWeDbQcjb94gA25vv8GUF4ihh9yE/H+j8/39KQ+S6v?=
 =?us-ascii?Q?TiMb5b4bmIzpGrjCicelDakyOeN043DgZ+vq9GQIfZtnCSYHrHJaOz13HmDN?=
 =?us-ascii?Q?iqbE7Dyh1iXA36YNgkZJ2sfwiXnq2RhtRGNOEr539E656XllZbQl4O2ZItr7?=
 =?us-ascii?Q?6d7BInrEozQ5uz2H6uI1u77cCccbd12sv4lcEdmmiqZIBEEohouL9FNzc6J8?=
 =?us-ascii?Q?mpGKak+j6ro1k7PSx218pG01VuHq2Pl7hnHAfkd9pPJWgfyxqe0yKQeiLbYn?=
 =?us-ascii?Q?vLUERX5ekGCEovqVsPjSNzJQRLG6FKAd9NqNKuUdWXttjlQdEIPa/0VjG1IX?=
 =?us-ascii?Q?6QiOdel2/f8XgLIxy+qdwiY4vZpT9wtIg5+eyaQsqW6lK6jBtZbatbhQ09KF?=
 =?us-ascii?Q?L1Uo+tlXJgLufo2MxGlRA/JKTZ4jb9WdV2tuCL5nPtoeQ6x6qwmVgGzCaHNm?=
 =?us-ascii?Q?sRnXd2W5YYbtoTmohj7Bgu83fT1FVz7eXDZlplnEs2lnXqH7s8C33bJ8xlIE?=
 =?us-ascii?Q?u9JxG0NWNMPtPZiomkO0/mQnuHcQoGHonh7HUPZ/nJZ9ctxsUHvSwXrtil8Z?=
 =?us-ascii?Q?C/E8B05zTjYbT4nI8+qctFUba1TN86eiuM/LxPuOfVsiHdBEx/ZevSVJ5mxK?=
 =?us-ascii?Q?LNq1Vqfa+UUu2thfpdNghyCe0kzRsa1tlRNANl9R5aBr8m+tiOAOYkzbNt1B?=
 =?us-ascii?Q?qgSdjqo5rOipOXlNMH/oNckincQYYozN3Cse/BkSovhU0CdL2A/Jpa2OKVoy?=
 =?us-ascii?Q?i/XVz5et5Oh3OUMxwBReczeP05eZ/hmjZgV43xETPGyH87PMlRzEqlOoiPEt?=
 =?us-ascii?Q?IVwicExT3SsimyWpLTDAH9ddMUBRWlSj052CCVp3RW0Znw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2741d9-7728-425d-d2e1-08d8eb0f73e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 19:44:47.6231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weMBumv+sw+ztt2CMFoWFMW46pDP84ePLNc2X28Y//pHEFY1pf+f/kQqdrX9wAJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 03:22:45PM -0400, Dennis Dalessandro wrote:

> > > [Wan, Kaike] I think that you are referring to PSM2, which uses the
> > > OPA hfi1 driver that is specific to the OPA hardware.  PSM3 uses
> > > standard verbs drivers and supports standard RoCE.
> > 
> > Uhhh.. "PSM" has always been about the ipath special char device, and
> > if I recall properly the library was semi-discontinued and merged into
> > libfabric.
> 
> This driver is intended to work with a fork of the PSM2 library. The PSM2
> library which is for Omni-Path is now maintained by Cornelis Networks on our
> GitHub. PSM3 is something from Intel for Ethernet. I know it's a bit
> confusing.

"a bit" huh?

> > So here you are talking about a libfabric verbs provider that doesn't
> > use the ipath style char interface but uses verbs and this rv thing so
> > we call it a libfabric PSM3 provider because thats not confusing to
> > anyone at all..
> > 
> > > A focus is the Intel RDMA Ethernet NICs. As such it cannot use the
> > > hfi1 driver through the special PSM2 interface.
> > 
> > These are the drivers that aren't merged yet, I see. So why are you
> > sending this now? I'm not interested to look at even more Intel code
> > when their driver saga is still ongoing for years.
> > 
> > > Rather it works with the hfi1 driver through standard verbs
> > > interface.
> > 
> > But nobody would do that right? You'd get better results using the
> > hif1 native interfaces instead of their slow fake verbs stuff.
> 
> I can't imagine why. I'm not sure what you mean by our slow fake verbs
> stuff? We support verbs just fine. It's certainly not fake.

hfi1 calls to the kernel for data path operations - that is "fake" in
my book. Verbs was always about avoiding that kernel transition, to
put it back in betrays the spirit. So a kernel call for rv, or the hfi
cdev, or the verbs post-send is really all a wash.

I didn't understand your answer, do you see using this with hfi1 or
not? 

It looks a lot copy&pasted from the hfi1 driver, so now we are on our
third copy of this code :(

And why did it suddenly become a ULP that somehow shares uverbs
resources?? I'm pretty skeptical that can be made to work correctly..

Jason
