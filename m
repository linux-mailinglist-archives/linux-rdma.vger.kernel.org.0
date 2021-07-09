Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52D3C27D0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jul 2021 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIQ7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jul 2021 12:59:11 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:12385
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhGIQ7L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Jul 2021 12:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6p7WPUbh0ON/qSnH/t54z+8RWNxOAWdnLOD8ilekYjSQsTpC06AWoo1P47T/0Ra2c6fIvggykOt8BTUWwDqPEAJ9eMgn85KWyGvK+E2LEHUcPKjADgAAwZ1iH009olJkxgx/2hchYGlX4oQjgZSViT0/MVzCG0nEWiIH/rHxQpy/eH2ViRrNMezJAcMtV4XeLjGAdvgQa8hmWtjwfKRMLTWvxUCXHub1lmGQVJXSiPED71qywZ9pvm9MX2QEm2Wo5RLycMBNAJrllS+px62TD39g/YIF4kM/bm/1QD8aKS/dUvQqWM6XIe0OEF3zwf1vn1+dEJct9iz3u8EMBecSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e227wTns826te/UhtpoKLY06aagRpItpnzZj+xN9k4E=;
 b=IJcFmBOKeroARXgOcLOdlIptEergeh3qu0ig2wsqRxB96Po5bffQNBm4sTAOlCooek6xJXWoWOyk95U3/gNBGEm1VDjYDAHZJgOjhTuiswnixESAHKKHpJTcn3xwfsWS1hfIiL/iG5B2UXq0ZLmOqV9i+10OZxFX1fVgtfvz/ER+U+K6QAMNN+fIztiAI/BLd1VYmDUYnxIM4BRtFVqBDP8Q8w0M8QAprrCyhJBflWqh790U31cRZbBKHXHTDm24wSdjLFbxFPKYwSFkkDnY90MSzy8RjN3rxIN89/9RNI4EY3PRMHvsOBuViBuHoljcejpPRQ08MKLdXTlZqmzPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e227wTns826te/UhtpoKLY06aagRpItpnzZj+xN9k4E=;
 b=A11n16o5FlBRQRnvRjie3msTyM6phcAwa6uvympfrklBn/2QO/Cavr0X8bOMlKE3kwOtDyr6P9XgAV46BbPfnqMiqGaN6S4tXBBnDfak3jpFN01STF/56Dk5lwSJJv732aAxshmIEQqgFlNmvaqmAQ5XiogFmUOZJ+ud5CUiqj2eSi1RT4sof/duCV7T5uDB8hEBYPJxIFtt14hbVcE8sJe2aaoWSU6WrLpCqm58v+VmfnG0GfCYIzuPH6E4UtaZc/F6dxotMi1FsEN9ZmaIIJqd2g4MdavZ1OmFzKvjZi8iRx2PN3vuq1tN9GNWjuy7+tyK8sW2zRF8sjW5kozH1A==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5540.namprd12.prod.outlook.com (2603:10b6:208:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 16:56:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 16:56:26 +0000
Date:   Fri, 9 Jul 2021 13:56:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Message-ID: <20210709165624.GB1541340@nvidia.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
 <20210510191249.GF1002214@nvidia.com>
 <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
 <20210705162628.GT4459@nvidia.com>
 <DACDFAFC-1851-4965-BCB6-FA83E72EC29C@oracle.com>
 <106645E4-DF2C-4DCB-A82F-ADECEBD242CA@oracle.com>
 <20210708185219.GA1541340@nvidia.com>
 <0F551BD8-4179-4090-B739-F30202A0BEE6@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F551BD8-4179-4090-B739-F30202A0BEE6@oracle.com>
X-ClientProxiedBy: MN2PR01CA0027.prod.exchangelabs.com (2603:10b6:208:10c::40)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0027.prod.exchangelabs.com (2603:10b6:208:10c::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Fri, 9 Jul 2021 16:56:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m1tnc-007Ego-H7; Fri, 09 Jul 2021 13:56:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b526e169-e242-4143-c79b-08d942fa7d55
X-MS-TrafficTypeDiagnostic: BL0PR12MB5540:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55402E87D08BBDCC9454D5B0C2189@BL0PR12MB5540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCNaiK29dSd84kEgGQgJor50t2fbwX8cdwHlUH70APQcIz8lNRl5b0UomIw81LA18q0cY9Q9EPJDkXrSZ/u5EqaGY+fjm7b/0y2oTZayQK9kwflWB5fgSKNAdFzSHfURhE4gRdev1hwpUg8lPOO8IjEN6fmbBAwYDBlLEFHYdR6CoIhIRvEzB4NBUL9vu9xyqu6L5tnzKuJYpJgSa/5wt7DKrerxKdTeAwYwZzepX80Yl3XgRqx8hvUzOfLeBJCR4Iz+WscJj14iu15F7pwBAszVqN5FvUPSEoxPxBvGJUmSBtk+i5PN53jthQmfHo1uQFHfHS+GA4Sr0iqUeOVpK1zh6KWMFJDdI/aynrZ3/fZmnlVymv53NSAhecKGUebmqknqZGS18rzqWcKrg3z0wEX95igCf3qdLjAZPFS2qvXorXDJFuY6WZKWt+Aofr0K7QK86omp7cYRtyRozSqcUBrCZSc/4XttjjREz1rRZVdNkc7LBig42TVkN05B7wUKKzQ0y/7B2Z2NoHNRQK9AZDY6KSa2siyZFFFPBLWdSCrfEaA11/IE2dnleN7wIyaSzBFsEf3e8teI4Qs/JbMaNGiBPNH68EkcfIxyoEiiozX43WpOvBNxgIJLmIpxK0++LfzfrdnaRACkP6E0joEogQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(2906002)(1076003)(33656002)(86362001)(186003)(38100700002)(66946007)(6916009)(53546011)(83380400001)(36756003)(26005)(15650500001)(8936002)(66476007)(66556008)(426003)(9746002)(8676002)(478600001)(5660300002)(54906003)(9786002)(2616005)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/SnhjDd/ZBXBL3roSNEPEwazIJMXzBIOdpDxlMpYdjdLlVxvacDBPwfsnq1?=
 =?us-ascii?Q?o9RLYQnEjyW8frmlNCoEuMZ8JsHTCzvoo0sOhE6vus0xfed1EROA78t/9PCm?=
 =?us-ascii?Q?XGwUv9qvFeWAIKYQnHq+PTBOLRGaPvALhpzAtGwOwM3OKs2XduqPNO1WMHnb?=
 =?us-ascii?Q?ltfp6L+oZQYzXBAWcjIKGC6xpE4WIImqcmXjTN8nSvBdmNbZkcx+mSgCotp1?=
 =?us-ascii?Q?rM3e3kcx5tGqT/IojN1PCXlVW0Sgcdm6+6PMBRcaJ5YeH1RRMI8gPoz370g+?=
 =?us-ascii?Q?KMoPIrx+C2ZPJBR6oHdQzyi+YAC1HFzSdbcl420Krm0ETj3PlKHMc1x4uSVc?=
 =?us-ascii?Q?evOtcJXnQ0bZsCJJEHYZWi8B+zx9EKyN6YYStybb95XUG8T/GHs+MnBpu/G/?=
 =?us-ascii?Q?+uad5LhEaYSI0XsJTt2pNZG6Fo/CL+/LkihNFa+oslda2jCy3TqO0Nb0RoRZ?=
 =?us-ascii?Q?lAFutseSomvBOyNpl5TTQ9/jUDHf8kCcumXc6NF9F3qgXD7hVfdImRQ7yZu4?=
 =?us-ascii?Q?so8FYe1xF2dd5YCMOHmU0Jz/5GX9TcR991/WmcAL5RivWk9yw03KC1lKf2Fe?=
 =?us-ascii?Q?EOt02ZG+ahP/jGSEPEFloq3RdBoJXbUgZZUcTv9rcGBpCc+E4N5WhkZh0KHy?=
 =?us-ascii?Q?XHah8LM5/1qGIL1qr+xm0nvGxsDnMETTnpvdxqwbJn/euCtkUy7qFnbmaYEZ?=
 =?us-ascii?Q?Iyhgfh7WyAzNIfmRFXlxEYb2S8G9zHZsm7Gg+0tZIR5oK6aO7LJyr2tqlLbo?=
 =?us-ascii?Q?zvEai4qa3IACS2xzfmqXE1iDOiXCF4jXWyj1Jb3/uxFel5Pt/YBwiu1fqGZ9?=
 =?us-ascii?Q?94mKlF4eC0OdnQ33+WeB2TDvVEA+S6ETdPH9AsSGNMcJkREr1DHlgH+wpI02?=
 =?us-ascii?Q?pkJPGPqSbPqqjDv3M9mqxOZ9klfJU+MyoVj4i0NyRfKL729gn0msMM1mmTFJ?=
 =?us-ascii?Q?0uk8YURt4JLvgM7qswGLNgHd+2+17mFVS2zIhcQ6fYrkQsbQ5OWyHZwyTKpt?=
 =?us-ascii?Q?UegC6Yu4f7PC6yzKZxxqWOONOYUi12rSThPfz8OWn42KFOOdDAc9XD1n/zIX?=
 =?us-ascii?Q?omUZo6Vm6OzL09YrZjagzMLYrzDvxWQjPrpZFZMJ2X7Q6YsAB6eywCNwGp6Y?=
 =?us-ascii?Q?op+9bE9OqGcLjYWO4iIfYBJD4pWPUD3v6IZKyeX3TPWr9oSzF5yzlnqv5TSz?=
 =?us-ascii?Q?8jD6BqvuWUeVC5sZ00F7QnDCVeTV2YgvJCgxlbfz7kW2eoJ2wMeqNSTk3YVY?=
 =?us-ascii?Q?H4bzqSlmX6MRDO0AWxh4yUukmwPCI8BayFpqGKTsoAbCqjA0Xi4Eq7MKC1GY?=
 =?us-ascii?Q?THVToCDo+VVE/9Oa51Tt81wG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b526e169-e242-4143-c79b-08d942fa7d55
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 16:56:26.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLPPRhCdodQoaXzwotU9RwHNZyKPWqjY45cn8TSkQB0/JuYJPnA4ACxrsRs1DafB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5540
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 09, 2021 at 04:45:21PM +0000, Haakon Bugge wrote:
> 
> 
> > On 8 Jul 2021, at 20:52, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Thu, Jul 08, 2021 at 03:59:25PM +0000, Haakon Bugge wrote:
> >> 
> >> 
> >>> On 5 Jul 2021, at 18:59, Haakon Bugge <haakon.bugge@oracle.com> wrote:
> >>> 
> >>> 
> >>> 
> >>>> On 5 Jul 2021, at 18:26, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>> 
> >>>> On Tue, Jun 29, 2021 at 01:45:35PM +0000, Haakon Bugge wrote:
> >>>> 
> >>>>>>>> IMHO it is a bug on the sender side to send GMPs to use a pkey that
> >>>>>>>> doesn't exactly match the data path pkey.
> >>>>>>> 
> >>>>>>> The active connector calls ib_addr_get_pkey(). This function
> >>>>>>> extracts the pkey from byte 8/9 in the device's bcast
> >>>>>>> address. However, RFC 4391 explicitly states:
> >>>>>> 
> >>>>>> pkeys in CM come only from path records that the SM returns, the above
> >>>>>> should only be used to feed into a path record query which could then
> >>>>>> return back a limited pkey.
> >>>>>> 
> >>>>>> Everything thereafter should use the SM's version of the pkey.
> >>>>> 
> >>>>> Revisiting this. I think I mis-interpreted the scenario that led to
> >>>>> the P_Key mismatch messages.
> >>>>> 
> >>>>> The CM retrieves the pkey_index that matched the P_Key in the BTH
> >>>>> (cm_get_bth_pkey()) and thereafter calls ib_get_cached_pkey() to get
> >>>>> the P_Key value of the particular pkey_index.
> >>>>> 
> >>>>> Assume a full-member sends a REQ. In that case, both P_Keys (BTH and
> >>>>> primary path_rec) are full. Further, assume the recipient is only a
> >>>>> limited member. Since full and limited members of the same partition
> >>>>> are eligible to communicate, the P_Key retrieved by
> >>>>> cm_get_bth_pkey() will be the limited one.
> >>>> 
> >>>> It is incorrect for the issuer of the REQ to put a full pkey in the
> >>>> REQ message when the target is a limited member.
> >>> 
> >>> Sorry, I mis-interpreted the spec. I though the PKey in the Path record should be that of the initiator, not the target's. OK. Will come up with a fix.
> >> 
> >> On the systems I have access to (running Oracle flavour OpenSM in
> >> our NM2 switches), the behaviour is exactly the opposite of what you
> >> say.
> > 
> > Check with saquery what is happening, if you request a reversible path
> > from the CM target (limited pkey) to the CM client (full) you should
> > get the limited pkey or the SM is broken.
> > 
> > If the SM is working then probably something in the stack is using a
> > reversed src/dest when doing the PR query.
> > 
> > It is not intuitive but the PR query should have SGID as the CM Target
> > even though it is running on the CM Client.
> 
> That is not how it is today. And because of that, all accesses to
> the PR assume the d{gid,lid} is the remote peer. To fix this, I have
> to swap dgid/sgid and ib.dlid/ib.slid all over to get this
> working. That is pervasive. E.g., even includes ipoib. Let me know
> if that is what you want.

It is only things that use the paths to generate CM REQ messages, and
yes it is the right thing to do.

Jason
