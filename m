Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FE83F097A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHRQqg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 12:46:36 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:6561
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhHRQqf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 12:46:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfCM53lYZsfl3nAKqQ6oeGPRkKGW+JZSaPVzvgsJSamZ0FRksZtNFoL9Eyu/dYB+s0m/4y9zBD7q0sikE4LFuvXDDlLCVdXCgsI8tH5zINZgdTRMfESYpj1S7t9ns/qhhN2SybRgWYgNKfNtqn8gJ6X7H1HsXMrTUW16y8ykZ0elhMXnHodtCTXdeC/URscIqf2oGoYPkFtS9NVqZizYG9rPO5p6pVyYfOuRIcyLvX4iBqDfzesHHP2VqVDWzrl2Vi/paljyxedakSPE0EjnnTfw4bKPMRtK+laav91qbGQePpDYTvYBNQbC/6mcqDKWapx51hKW16crjGNcwRTXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBpt5yDM8IuZyIDp7RB/OwbNWHn7aDtNGEb7ljlfPaU=;
 b=Uub7a8N63i91elmPC/CVZCI+EtNUfwczDrre+GHr86lKTxfWaveMmIBx5pZxOgyOKQpb7O6x0ANkmmiT7lywqs1J1eGLtGux7vn02sVa58S/eDyc6iLwabo/uy/osUFULBU4K5zoeqUeWju+JLoyuwljdY+wNSSZ0lRETB2vPzztMjMzaztmsem1K2oXG+gee6XsTTx3yLurh1WTR/Aq/zoV8CtrroCLKsHT86WuHwklRnx8b+Idd6IUBiN0ob3HXFbeL21p7zGDHn8ShBB40rNiTJqUma9cIg4l20Qha4m57tmp43wnohVnchgkYcKVynLbqHidvdh53v//e1w96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBpt5yDM8IuZyIDp7RB/OwbNWHn7aDtNGEb7ljlfPaU=;
 b=kgQP/EG9wBcUd6UKl9iJl4fZqxHb//f6wGHEkVt8M/ZmdtboQiAtwRKi0lXLBu0v8JaA4VqlvRlsurbDNjzeAJ27vCcnSz7fqu0dLx4ID4ixj1XjrXFMLnXhm5hHOtsy2o5ILENBPmJsCrEwn0079jFwkEIsLdDDCNb+IMzvB+OCnf+GgAPLcULD58Q5GV6PFNdwrLRmr8KGwL8ePoPdt9ST2e3ZH8qvd/LPrMMhATtwm4I8VMBtiaoep/Vr5rVdkLcJzQmTVEikmScukkC6x6CBuwl7CF+3LaE+8C5nMNoa48ThdaWDCEC7meM4yUNj9Fq072px9485ZX82brAQkA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 16:45:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 16:45:59 +0000
Date:   Wed, 18 Aug 2021 13:45:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] irdma: Add ice and irdma to kernel-boot rules
Message-ID: <20210818164557.GB5673@nvidia.com>
References: <20210806175808.1463-1-tatyana.e.nikolova@intel.com>
 <20210806182852.GS1721383@nvidia.com>
 <DM6PR11MB4692C424F3B5AB513B0EBBDACBF99@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692C424F3B5AB513B0EBBDACBF99@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 16:45:58 +0000
Received: from jgg by jggl with local (Exim 4.94)       (envelope-from <jgg@nvidia.com>)        id 1mGOhR-0001Zf-Mg; Wed, 18 Aug 2021 13:45:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a17f26-eee9-48c3-90de-08d96267a801
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52702D3D1F7900C930EDFDA5C2FF9@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2EhdIWzgytGscFK9WlhF9QZz4OA1QR6fRxS/XMovQutgDN13cKRpwHOF/8X57md5okBO90cof2ZolCQ3lh4NDBJtV70nq0kJT8dxRjt/hhF+06Fro4WAfL8kvgjD4wPF7TByv4bFckOlFNTv5EDkFtAw43vVH8Py1F2sjD9zIfsi88oPwCTgwDe16f5p+A2Z1iW7TMKEOMrJWojQk4pAieKrFQDIe9qb5cm8fZmq6UMGEZaldheUOLdOzwh05BGYp5uWL9pwCpycovVG6HRkWgz1M65SL9hWlnWvdwJC48pWsgsK9WTyeR/uf1UXjuboaZAAgJx8f9IzoBCho1/bOFX8vCML0aaBQtQzIqFAnSrXfX9A3Pbp17pGVyX2kybRrqPytX/cWdlN907GwhXezKnwxbqoagngv3EPVzFc7opYmqnq88+UG4KcOERkwSg/s+GewT+T9r0xr8b+Fmy76tyZAVS8QnZEOtlk0ayYLHeaxajQd14F7RPEM08Hh5cqspNfoqv2OilA9E7ivXCGfMF3CIQC7PH9IQy2fy+Dxmy3mmngtGBORCrrIsDq8rY6DLSWXBVkFT8bmaJ/Lsd/8To3THgsamdlmjoVz2ZsrZtRjrzo0bnw3hiElG5APp1yqaJDpa9M7VQPtgj96/plw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(8676002)(66476007)(66556008)(54906003)(478600001)(66946007)(2906002)(426003)(1076003)(9746002)(9786002)(8936002)(6916009)(86362001)(186003)(26005)(4326008)(33656002)(2616005)(36756003)(5660300002)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SNBauAbI12P16lGOzQMbxpUBTTn/4fk+fI2ObEdSsRlWgVAYzO8tsxyb6sxf?=
 =?us-ascii?Q?yKQm7xwRc3GK3Th9y63fI8XJTsvgvfhp13efiNqc2oylk8PuwlqWJpR22li8?=
 =?us-ascii?Q?EmTLb81bLBT115ykghLM+IhRLPB0LthRwrtrsMvxBpPpmjkmjL61cyvOa2bM?=
 =?us-ascii?Q?5nbp6/QA7BEwVYjIGA8n00LMaBpljEYmj5Zby/le+j5Yh4atWFiMXLTb11kt?=
 =?us-ascii?Q?wiiQq/PAr0Vxmx1j2Duorq9idoRTdpWQhImiuL23M/wrGlkhVmAuzDzpiuOY?=
 =?us-ascii?Q?8ULjlNnF62xa/ui/DJCpgPQ/XrE5F+NWXS7ejPF4ETFG9KHcKMuMrtTTVdrh?=
 =?us-ascii?Q?gKSuxP8mwQOADKa5MZCvxxKDXre2j//k5ki9/tfELL58/t90oDPrA5wPKBWB?=
 =?us-ascii?Q?hZje3qRgAwJ9CqcSkxFpPJqk2U9ddlEbcGb/z7pDW1hlQae9DHPG4InOQ2vp?=
 =?us-ascii?Q?iBep9/b5XZTxLAslPMl3Olp0l3Zr/nyF1PdChFduM8oEleI9YC5ji0Fz9ngI?=
 =?us-ascii?Q?s5Qiv9yHuaq3BrLoYco58TuFI5rxYrmz0WV+Jzj2cnfleh0sx7XYJba7ql3l?=
 =?us-ascii?Q?078OU6oPOweWKoKSh7J0yZxQhZv1zzsEyipEUtx1xcL/NNyLpzr0VQp5CtvS?=
 =?us-ascii?Q?ovfcqLSxz+3Z9jJ7qEYHtE93F1lib6FgnPkLXBpbwkDpt7hQNP4hh5a7Oq0k?=
 =?us-ascii?Q?vprloLpDzhd4w5uqLteJ/17DF0XyeB/+Ao/pZ1m1RTSlgPHmUtwQRB6+R9Q2?=
 =?us-ascii?Q?9H0VaR5CxxVbiAA3y2az1X8HZKyBVygJtkhSQI/u/qfeH4GVcOZTwNpXCWTK?=
 =?us-ascii?Q?srJw1huFS3oVzlM+FmDMDM/3Bxjfk6Avcbf0+AAg5pkEekFAGY2xzSWM0feX?=
 =?us-ascii?Q?FhClhB/IXOhMT0GHbcL+1ll4fbRTiwFf5McjeNsUdvcab3fOTL4MX0+yN5pw?=
 =?us-ascii?Q?7Trkleq/LP55SrIkvKfV6R15lFz2kFGJ5h9RBxqAIDfX8ccCnvN7MMWZPxk/?=
 =?us-ascii?Q?HA6LFBJrsLdea7MTTktw2Fqhk2Ccqyc7hTH+u+e2ILXtc/X07A91cg3fsAVw?=
 =?us-ascii?Q?orJl5WLdxmou1LMZJIEActUaUshAbXCMJpuMMrCK9tNbtT5DFdcK+jaix9qM?=
 =?us-ascii?Q?f0e61HlLpCmHbAoem2MXoU77VBVTZ5Mn34JMAvVdeq49FP+59tiJgo3P3eP6?=
 =?us-ascii?Q?+4yw8G+JklRa5/ne54zA/wTTziCyGD0En+AFjeMPvCbjlw50RWfvAi5NMtnG?=
 =?us-ascii?Q?OIIs+J/2vEt73/CdwvJoGfTLUQVP2I4dpF4KVbTvs6+Ht7cqGFQyYYTg3DWj?=
 =?us-ascii?Q?aANfMne+VJFCSIKSG4siexAs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a17f26-eee9-48c3-90de-08d96267a801
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 16:45:59.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz8AXp/C3otcVWTXk52CMnssx9FjJzAx04Wvf6VFqgK8POEyru5gnoEHwSX6rw+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 12, 2021 at 11:33:04PM +0000, Nikolova, Tatyana E wrote:
> > > @@ -12,6 +12,7 @@ ENV{ID_NET_DRIVER}=="bnxt_en",
> > RUN{builtin}+="kmod load bnxt_re"
> > >  ENV{ID_NET_DRIVER}=="cxgb4", RUN{builtin}+="kmod load iw_cxgb4"
> > >  ENV{ID_NET_DRIVER}=="hns", RUN{builtin}+="kmod load hns_roce"
> > >  ENV{ID_NET_DRIVER}=="i40e", RUN{builtin}+="kmod load i40iw"
> > > +ENV{ID_NET_DRIVER}=="ice", RUN{builtin}+="kmod load irdma"
> > 
> > This should not be needed, right? The auxbux stuff triggers proper module
> > autoloading?
> 
> Hi Jason,
> 
> Our module depends on the auxbus, but we don't know how the auxbus
> could trigger loading of irdma. Could you please explain?

It should simply happen automatically once the aux device is
created. If it doesn't something is missing in the kernel.

It works the same way as any loading a module for any other struct
device, the aux device exposes a modalias and the userspace matches it
to the modules.alias file and then loads the specified module.

Jason
