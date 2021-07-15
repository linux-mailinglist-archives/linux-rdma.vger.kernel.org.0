Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0E3CA4E0
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhGOSDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 14:03:52 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:22208
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236834AbhGOSDw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 14:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch48N1TmCuO2DQAErSkymBNB//U1g6z5m9mgipU5QIVZEFiUtVJB7iFj2oUdReiOynDe6TaIca9g0oZ8nM5j+2PP6u05wmdEldlTaZtPEYVQHti5oVdnxFeEIAd7SE8xwMetooJWSDeEReLh/DMzq4C7phfkUg34cUUSXzEI5LVoxsEUGm5kmSDMLJz3kHndDPqgV2niMol0p+e0/io69e4yzkqcgIeIicL/7LPSNQbdxLyLp3/OLdpmiwhQ7bFjEdvqxjFQIMJOTDLfasH+DV4KnWPoN5VtF4Zlzsn/xFXX/fQKrLA9M35qUhczhD/02fxwYOdvZ9B1lnBQXmmwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FznIu3Zm8A9Il+GuhNJq5BJ4B/OHygABpD9sNSrPv0Y=;
 b=gmpC2AVwrGKPewSyAK2EzxveLUuOBIDTVluVhZhsGj8Q4rai1xsLZZrygM3bF2ZB9JaTdWGs5X9ZZD2oNzyehy/V124+qDfecxqbU+UKpQ4Z/ZJneD529w5e5evUdDi2isYsyV82FQUah9tp366z1hk6bA6ghPeaK50OYdb2xHRSQzNeBiG19K9cILm/6p0rYEjbfvlt/8iUAAvfWsTRG9vSrUzDAXK1ZTMEHwKn8HXyuRgwmHeAbOYcOKVIIvLRxwgeOrNA1r0by/1LLA19Xnq0Kjw3z2ke3eHXnM82icfjSM9ZFrDxGERSLQP/nkTeRMOcl0oVyqH+tLODUnjXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FznIu3Zm8A9Il+GuhNJq5BJ4B/OHygABpD9sNSrPv0Y=;
 b=eb83scf3ucPg6g7Ev1KVY+j22Hzc1AB+d1QPWwEaGmG6L0lNg11ds61rgivtT9jkF3xLIx4nxT51BM/NHHSKk//Z3vIaEqKtUO5U8U8dHVLUCitzNh2cVVrO5EDcotfOfbjRAKlWVPcbsrUJLVmxKqR3Pyfyb4L+8hvwyLrcmIRgE1waiWkBQp0m4f0MBJ4Rl91TuI8sDs+8K+rlyamh45ZdMu5qdEDneSbAHV3UTOA/eZRnBcgV/P9DWiuoX/Ew2L8QG4HmRH/L+YissjxlgfBzXB3S2bswEH/0NQFGZoHMQqHNiufkjTDa78KWvxvVJJtBYkVhCt3gHO/o/jqgSA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 18:00:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:00:56 +0000
Date:   Thu, 15 Jul 2021 15:00:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ira.weiny@intel.com
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
Message-ID: <20210715180054.GB667398@nvidia.com>
References: <20210623221543.2799198-1-ira.weiny@intel.com>
 <20210624174814.2822896-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624174814.2822896-1-ira.weiny@intel.com>
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 18:00:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45fK-002ndZ-SF; Thu, 15 Jul 2021 15:00:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f41b165-ea09-422f-6b44-08d947ba7e95
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5191683B1C015E1DFB7072C2C2129@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtNo6Nqd3PLJ5xSNpxZoDIGrPwRLxs4rCrt8aGslNSDIUSca5ztnNsIat0XHrnearvxYH9ie5syNZri8G7zB5LSyTymeK1oddXDJWRfpnnYcg5p34thIdfEbwh/ZTDcyzbWEWAocLDy7UyAAPXd3ZJteOYEkPvajuONL1zwu10/HRMqi+ig60lU0BGFqfxefFZWj+iLHocKmkrdbIACMKCX4EmeZEjk4zrybkp3TUzrT2zppvm58+9LsQOjSXoWWI8RlAXyovGElGeUAQ2Ose8If0xh/2/m2u0pYwIzcE1MARTrtEA0FkZjEd95gedjdwQCgySXHGxAOaO3cjlTDMNrb+gZ2Y87yfHuaWjxV6IhMOUjPO8gjUy3TwSlX0gkNCr6ZEAvA2/lhRXxm7qJzfNBfmSqiW6iCk4KHjbYkKWMXg0oHlHg9lWAL+V5/jGPxtDoplJSrg1UIlCBdWVBJWbkLb/hyrjPq931QRKKb/8vg6MGkD8k7pl5gQE/5t8DyopIv3vPyzwXpxl5ljQvMWKOJbk5OBhvITjs2NM8ZnTMM9DuPZzl//QUEX5JrqmWr5tE4eUern+R0fXNOtSLMzWbH0+DwrpTsAcszUuU3H24D0FMW8b0xEvFNkTVM+tPALWgxI7wy/WALNgTmjUvhxg2WUyp4f4B/w9AAfyhD5RsOM1q2QKvd7UDPL6vnbfwvCYQvkZ4U9esu/WqoR7ibahKp6f5yDULViVerYBAKZYXaj3IWfZ6R9LId9bO/rcxVUjOK7g/6gDQu1Bd4L5GoORMtBsQMPs0CM1FS83kNsWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(8676002)(316002)(26005)(478600001)(4326008)(9746002)(1076003)(186003)(8936002)(66946007)(54906003)(5660300002)(83380400001)(6916009)(9786002)(2616005)(86362001)(426003)(966005)(66476007)(7416002)(66556008)(38100700002)(36756003)(33656002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnfONk9AvH74rPs4yDEEc2IM20JZT2e1aPqInrtn61ENzc6rKD6RuQBZdREH?=
 =?us-ascii?Q?Gy1uPTcqsDhp06R/yGNCV8CSWL2Dxmj0Sw6arkG6ON+HoXbG1i+J2UUXIFYg?=
 =?us-ascii?Q?YT8hxlQcms08ZiOm0xMYZLaLc+Pv7jlArRVnj5eSFRO8xZb7nEInyGmWGx2i?=
 =?us-ascii?Q?VnT66OzTo8HLQS9lF0zKaXpxSp7ZlXe5buHlY+bwjeSVQjV+QR0G75tvlD1C?=
 =?us-ascii?Q?pGMjUX1rs0hVfIaoVi7tA5u8QX1INSMm/vx0IvXt+qZa5rGgLKTxeFepIF+/?=
 =?us-ascii?Q?jA9n2o+nFLbu3hirmvkxzEMJDK0Ws6KTt5GcL0casEYqq2MvuyYaB/rOSHKA?=
 =?us-ascii?Q?Z3kFbFUZs33VCCSFOq1+MwhbkbmrA9wDjvnxftMnaKdRAOVFMtZnSyG0PjxT?=
 =?us-ascii?Q?HiAy0dwMg/t7vDU46SKWgAzTLlhjX4WO7Fn+YaGrpnui5GU7XSxPxe3Ya2Xt?=
 =?us-ascii?Q?hJgBogpsLrWIngwM3k49qYUJhmGSKOmAZAsUmrimY/qaNGTZ42HbLiQcQHfJ?=
 =?us-ascii?Q?PoV/gS4OWnFHy2U3u7+e9xRo+paS89ADKlZ/QeXsePp553OChUT1FqzOdMiK?=
 =?us-ascii?Q?rIX7tG8eBFGJlIqHUEr+rL5T09emQAxJmGDtcy78pU1eh2zjHh9GMFKHCxVg?=
 =?us-ascii?Q?yIcFlRxYK9WkL5gcFkHZL+ajy1pXqFi0Ku+kzXOIZ00Hn9n94g1eTQHhGefB?=
 =?us-ascii?Q?OVrCL8ju3CE3cAGbvuc50UKQVbxddVPmIErBGPd2U8Xeyyo9z47C6CUH+nWO?=
 =?us-ascii?Q?8PsMRPl6e0oIfGwfriJ3rUdGiDt8678Eodpl4OCLj1Iue7LD0v5s+GUXYXlq?=
 =?us-ascii?Q?J+KIwy7+WoXvkEGJe/GVBD/C0vFPwH2aqPU12k2ykCKwKYToL2T6pN2SeyIy?=
 =?us-ascii?Q?nABIHucSvMCt+sQp9zMVvqpNfm0oRWdOpxRInQp0WuHkckiwQMYgq+5RkJ60?=
 =?us-ascii?Q?s5uO7sYs/i9upHkD1koa0yq7GIk32eyfX25upWK3//LETH9ybWOlkBuT23NE?=
 =?us-ascii?Q?YfgKI3YuRJRTdX2qgw1J56XpMXA5WH21LroBU+9uwUNrKC6tQUQxXQ6+03Im?=
 =?us-ascii?Q?cqNBv4A3HpGJgjpBlLjom0r4TrG36aJ6OIoWeCOBSF74bh6Y1kfcyGs4VyYm?=
 =?us-ascii?Q?3npsW09J05IYtnjSdlggpLNpaqknk2Vq/HffnE+4YtgHfWeGLo4nZ7qpLlYb?=
 =?us-ascii?Q?in+ztNJXxS8z78YfWDTUPampbr9SAp/tDHDsqe+PEyEsb71yHDiq8PvgdVzI?=
 =?us-ascii?Q?Ie0rHtjrBBZXm5KA9qs2xVwLyBxGY3qduHJkeBE1er70UdK0n+M+rb9xtT5X?=
 =?us-ascii?Q?QOM+IUeKEcGq7bPd/gGHIA+0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f41b165-ea09-422f-6b44-08d947ba7e95
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:00:56.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFiEiyMxy2rPmMppX0QvW2QBHn1tyt2VQmngHUNua6Cgy1ojQi+YP5U+t1RUPS5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 10:48:14AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap() is being deprecated and will break uses of device dax after PKS
> protection is introduced.[1]
> 
> The use of kmap() in siw_tx_hdt() is all thread local therefore
> kmap_local_page() is a sufficient replacement and will work with pgmap
> protected pages when those are implemented.
> 
> siw_tx_hdt() tracks pages used in a page_array.  It uses that array to
> unmap pages which were mapped on function exit.  Not all entries in the
> array are mapped and this is tracked in kmap_mask.
> 
> kunmap_local() takes a mapped address rather than a page.  Alter
> siw_unmap_pages() to take the iov array to reuse the iov_base address of
> each mapping.  Use PAGE_MASK to get the proper address for
> kunmap_local().
> 
> kmap_local_page() mappings are tracked in a stack and must be unmapped
> in the opposite order they were mapped in.  Because segments are mapped
> into the page array in increasing index order, modify siw_unmap_pages()
> to unmap pages in decreasing order.
> 
> Use kmap_local_page() instead of kmap() to map pages in the page_array.
> 
> [1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> Changes for V4:
> 	From Bernard
> 		Further optimize siw_unmap_pages() by eliminating the
> 		CRC page from the iov array.
> 
> Changes for V3:
> 	From Bernard
> 		Use 'p' in kmap_local_page()
> 		Use seg as length to siw_unmap_pages()
> 
> Changes for V2:
> 	From Bernard
> 		Reuse iov[].iov_base rather than declaring another array
> 		of pointers and preserve the use of kmap_mask to know
> 		which iov's were kmapped.
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 30 +++++++++++++++++----------
>  1 file changed, 19 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason 
