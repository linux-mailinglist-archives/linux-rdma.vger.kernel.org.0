Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97F6599D0F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 15:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349280AbiHSNjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348729AbiHSNjP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 09:39:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EBCD534;
        Fri, 19 Aug 2022 06:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj6WA/XN5QMuCF1O7p+PbmL44ZMQpUUuYj/2EOVvTDbwEA4NY9bigpx+ZZUE7XrjYNjWlBqj/7iWMdflZgtI/Bbz7BYn9ztb/HkE6YKN3cp1KVSt6bkHZS1j8VEf/CWJTNDzFLvo+N9FxuvJwy2T0g9I1UJLa7Ck6vMxtOuD6JYN1MVlKlGQUSTsfoOut/SxvMShe6cO7MaNEOT5YnkdKsskT2D5E4ik5j6pO2RWyTTSnutMehS6bxCSqjdHGgRSLjJuzm0PCoM/3j0zr46KJ2advH8u6zkGpYzHX+zqxjuh/ht562Xa6HwirVWkLPSRjkidXlHL1i32meIjg+idmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZHObgA4IhetUpnkhWk8AAyg9OYtimaQTWo3P3AWspE=;
 b=oTax1rnFc7MWCgULfxVsyBjYfnYCDUUJJ6VilMD5zCW7wITSFxyd1ignpNQmgEmAORzzaGwHfZWS6kCshnUkWmmpQCKIXc0Zimwymc0vI9bAHl0+VfveUmUyMfOIEHoKbeeMp+MdTF0/hhIKtLHpvToS1sb5xGDLUT1tyP9YNWatgCxELoF/nhUo9ovNFlVks02vD3rHkk0/ut+cElVHkRTHiHUGkxkdpWjKw58vX9ulX9oqnT/54TbCvNutuvZLsyeF2VqlXAJ1bS09YfD+831K/MwUjACnOe7t2Ofpk53WvCkdrYKIHElvknoLZgSlAwb/ExXT8ESuUzqY6n3R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZHObgA4IhetUpnkhWk8AAyg9OYtimaQTWo3P3AWspE=;
 b=H5WdiCohQVQ1GMC9GIgu57qh1f5RwvhIx1WSGc0Pe3yjwvl4uQoLTmgtnd/NQVMQbUJ9SJ6rcxZyqAFfOTANFv129k5P649LCZ1TMt4vthi4kz0kjrzTh0+c2lPhZQPRiFtmOoOAv+W02oR+aTm1KaqxWR+FXdki9YpXFi/m0SuSeY86JU3xsiiskgmcslHpa2ajzPjksi/VaZsb5qwph4IHwTM+/WeTVXYTU9zfw2xkhvke7sXYeQWOfH/F1OkWg/NakNHmIh38nVlMjK+xdYuNthCR4q8zBRijZepF0Z52az5nfQ8iR3yCn9IQYmK5WM4+5kOZUwa7/x/kf5Htxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 13:39:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 13:39:12 +0000
Date:   Fri, 19 Aug 2022 10:39:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Oded Gabbay <ogabbay@kernel.org>
Subject: Re: [PATCH 0/4] Allow MMIO regions to be exported through dma-buf
Message-ID: <Yv+SfymnK9RF0qTA@nvidia.com>
References: <0-v1-9e6e1739ed95+5fa-vfio_dma_buf_jgg@nvidia.com>
 <921de79a-9cb3-4217-f079-4b23958a16aa@amd.com>
 <Yv4qlOp9n78B8TFb@nvidia.com>
 <d12fdf94-fbef-b981-2eff-660470ceca22@amd.com>
 <Yv47lkz7FG8vhqA5@nvidia.com>
 <23cb08e4-6de8-8ff4-b569-c93533bf0e19@amd.com>
 <Yv+MD44ET211LMIl@nvidia.com>
 <a29de43e-2dec-fd27-2e24-31af1d3ce470@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a29de43e-2dec-fd27-2e24-31af1d3ce470@amd.com>
X-ClientProxiedBy: BLAPR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:208:32e::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cb4a828-c878-4e99-97af-08da81e833a2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeZzOySSgGm9b2jjR8EBd4fnErAZTYyPHDcjDOEOnrnNugU+SiqHoOuVJ2kDbpo4mD0Ycj9/6GhwAKD8UXCpx4QwgKDY30dkJoTyQk5qgkWr6kUG2VUep/EM4qfJMES3m9GbqNA/n03rG1IfiqcjOh1mylo/3KUK2ANtE6pguQlRt8uWW2dW1Mol/PxTRZwn5YxvfA8xbMCl8FDwV71754C7bDaCbSbHyDHXIxSQfW5Jz0LsOsYx4nq5WhYP5ogo25MzVQFyobcMXs77SMlK09cv/s0gO4h8jdNGmVY6DEI32k0dKpCWMFvqjK5qSbgBSpcZtIXDd2ktDK6z2mTtLpeiBSBYKWx2Li8QuE7t78xM2V34hgVWd+9diGRzypuZDOdqCQ6DRPNa80PXhGArmhK2WHtjFnzgdf2Vuah5zkP7wlSm7VaUuzE9iSmLQj4xtFrazD+I329KrjVUE3ZBMdIrGs1X9AoyLfsj0B0frDe3dPvJa6jnIw1CkjawiffDU4XLBwp0rwbzcxEwWSWppHtcQaskD4JnHPmecw0DMQtXEfqEENoOH7U0lIZ80tuT8ZvPEbo8Nkecdx6z/igqa5oLvFRgpmyjDDHorg5qF9morxB1bQxsJ+S8hPDDG0ngv+noXUlzNZHPlx9tPcTCy/jZaydYzq++Pp/1sNJehItCu804gxsoUCilNnJRkF8GdgFuLdY6N+TqqL6blPWY0jEm3Rsa7591/2UYVoV7/0p/1dlEBN2azLTsEoUNuwTM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(86362001)(38100700002)(54906003)(8936002)(66476007)(316002)(66946007)(6916009)(66556008)(2906002)(7416002)(5660300002)(8676002)(4326008)(2616005)(6512007)(186003)(83380400001)(66574015)(6486002)(478600001)(6506007)(26005)(36756003)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tys1RndJY1ZLOThhek50Q2FTdkY5SHBxb21aNjVEem45TjhsUHdLNkN3Y0dR?=
 =?utf-8?B?YUJJbXB5ME1HOWFXYkNlQVUwRGVPM2J6UTN3Y25HYVJQMUEwa1ozdkZuUlpI?=
 =?utf-8?B?MEFVYUlXQ0lPR2tpQVhxdGJ1TDc5c01OU3k3YVF0OTB3OG1DNkh3K1g1ajFP?=
 =?utf-8?B?ZVZiL0VFbkxKME44YmI1bGFoSEZIZ1F5bDBXYjFpNGhQd2lHNVU0VDJBeGRi?=
 =?utf-8?B?U2hYZk1lTlZ1dklHa2F6ZVFOemw2QTJiTG54VWJUTUpLNklvOGZJa05aYkdu?=
 =?utf-8?B?dE1pWDdoOStmY3FCbEgralQ2ZlpFemFaTmplNDJteEExTGxKaVBrOFVtNzlG?=
 =?utf-8?B?L3BsSTYrSmNCNm1rK2txRXZud1Rqd0Q4MHo1Rk1EdFAwZzAyVDQzazlRczZ4?=
 =?utf-8?B?S04xaytEK2d1SkZpUTBWL0JWVnBXTjljZWhtL01NSEh4b0JOMTFBek5vcUlz?=
 =?utf-8?B?bG1TN1VsM1lkcTYrUS9paHZvbTkzTit2Zjl3ZlZlZjhPVzhxWFd6cFViYlVR?=
 =?utf-8?B?NTIxWG1CaktpRnorMFFqZTYvamhZZmdVK21sTW56SGFtc0tiZmp1Vk8zNG8z?=
 =?utf-8?B?S0dKQ0ZVbFhnSHJUZnA1Q2ZMTTdxMU90Zk9ycStyMDZERk9wZTc0MnRSZlFk?=
 =?utf-8?B?cTNLT0ZXV3NZRDdqSTZ3TzgzSHErd3p0MHllYjI3WkFGZlFEdy9od2N3bXVC?=
 =?utf-8?B?TlFCVVNzNDQ2b0xjMXF6SjFvcXdiTGJZTEVqSUNLRENLelhTcWFyTi9CVFEy?=
 =?utf-8?B?K0I4WStPY2ZJM0NPSmNyMUxaQzBmL2doNTcwa0c0V0k5REFtVlR6elhUMUlM?=
 =?utf-8?B?U1RTYlNRUjR1MDRkbzlHdDB6ZG5jVDExR2lvZ2lmS1U3RVF5SUVUOEFTbVk3?=
 =?utf-8?B?WGwvY0dFbmYwMGovNkRENXZoVjhnUHR0TXhzWEdPV3ZNNCtyR3BYRTBCd0pE?=
 =?utf-8?B?bW9GN1lWdFJ6MGNnQmZyYXl0MWJMc1VsNmJpdHVLMkk0aXRCNFZVU01najdq?=
 =?utf-8?B?KzFKNEhETS9BYjVQbjR6YU1qMlc3N1hoWmRHRGVtZWRiQlZJajFQVmJ4YlJ4?=
 =?utf-8?B?bFRROEx5VmtTSmUrWmk1MlppbktGbGlwZEU5dDdKYmxUTjYvNXZDWnFObyt4?=
 =?utf-8?B?NjRZS1djSmlPdm9IQVNFZjdvKzdsMW9BR3NwbGtGYmxmWVB2Y0FPL0RyQUVC?=
 =?utf-8?B?akYyTDU0VEczWUp5cDRNYUZFNzRrVkhRRDlVNUp2SVpXaXFldVFYMS9MK0tQ?=
 =?utf-8?B?STk3Z2RlUGZHNDZPV2crRExYWEhoWDJUK3dxOXJiMTFiZy9lZ3F6bUIxTTBm?=
 =?utf-8?B?WjdhMnd0ZjlwRVVhU2J5NEF4R1ZZWW5zT0hlYVRwOE8zMjZUNytRYitWREpV?=
 =?utf-8?B?bk9EUG5lM3h3U1FyeStTc0J5bThLMDdvMEFhZ2JRc0hJbjRVWmxnZ2J4TWs2?=
 =?utf-8?B?QlUvTlZmUjNhbmwrOFc3R0FjVjdlMStTd204aHM1V0l4TmxlcXdBVHNUaGVw?=
 =?utf-8?B?Y25WVnU5NFdnRVA4V1VlN0FYME4zRXFPNGxjUVYwOTFMcEtiVG1sT2xXZjYw?=
 =?utf-8?B?N3NQc0M0MXVQbjRSM2VZbEdQbmRKMklLbkYrdERrWlVDanQ1MnFqOGFKL1pR?=
 =?utf-8?B?R3Y0RFRQbXlDVHlNazdqTEJRYlNGU0FEOUZjbFdKTC9mUU9teGdTVkJLTWVq?=
 =?utf-8?B?VG0rU1V3NGFtNkZPNjBjWlFRbk9sVXY4NUl6cWhnTXliMWxZd1JJdkdoSTFR?=
 =?utf-8?B?dkFpL1pMTjNvanE3SnlEekNBQzNHOE16MXpicnFtWlBKV0hqUmxKR0YycjNW?=
 =?utf-8?B?Zm4vRVlsWDlUZWlWTXBkeVJuNGVHdFFSbW1QMWI2Qzh5akJ6TjJuWFA2bVVD?=
 =?utf-8?B?NzAveTVzcyt2L09yZm15NzkzTVI4TXB0VlVxZm05KzB0cDIvYW5RVlNpTy9z?=
 =?utf-8?B?NU9mK2E2NFhPMGNVQjVManhaWGNNUW43a0lld0VPVFNrZWhiRkJQdjl2VEc4?=
 =?utf-8?B?ei9uR05HeEMrUkwrUDVMUnU2TzByNi9ZN3BTeUJ0THJsdW9LZTRSL3VoQ3FS?=
 =?utf-8?B?cjh1VGZ5emUxdytNY1hhWStDMlloSzhaRWZmUkU3aFQzS2Fxak53dHkzOHZj?=
 =?utf-8?Q?tfJjof7Q8sDRk1n6pJ937bo+7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb4a828-c878-4e99-97af-08da81e833a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 13:39:12.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCtoXdQxYmaSUOKlUEZEA6OEq3E8OzUACdWyzGDH8XRMMTb0qrST3nnrF/WUy4jn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 19, 2022 at 03:33:04PM +0200, Christian König wrote:

> > > > So we could delete the try_buf and just rely on move being safe on
> > > > partially destroyed dma_buf's as part of the API design.
> > > I think that might be the more defensive approach. A comment on the
> > > dma_buf_move_notify() function should probably be a good idea.
> > IMHO, it is an anti-pattern. The caller should hold a strong reference
> > on an object before invoking any API surface. Upgrading a weak
> > reference to a strong reference requires the standard "try get" API.
> > 
> > But if you feel strongly I don't mind dropping the try_get around move.
> 
> Well I see it as well that both approaches are not ideal, but my gut feeling
> tells me that just documenting that dma_buf_move_notify() can still be
> called as long as the release callback wasn't called yet is probably the
> better approach.

The comment would say something like:

 "dma_resv_lock(), dma_buf_move_notify(), dma_resv_unlock() may be
  called with a 0 refcount so long as ops->release() hasn't returned"

Which is a really abnormal API design, IMHO.

Jason
