Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDED842E4CD
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Oct 2021 01:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhJNXiw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 19:38:52 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:60704
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234410AbhJNXiw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Oct 2021 19:38:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dvo45W5GZXrcvax+NHmy2Xfs/eN3/r0uRX3yR25dedLYNKguA9NjHd1ATZJUsQmpHsjrA6nNWRCRzvPaU5oU82CwU5p8RZJoiS1bGoT8ZyamWm3AjDVYjL0t30bTtKHxrDfQWYcyEBLuzUWRxJHnvrn6FDuW2f3uwMCDzhbrzHgXWySodMru2s6Zfka4MPuJBDnvlQ7TWSd37ZSfZyKQycNkg5NPpACK+HtPS3ykIMTLcTZvknc050oxIHJvJsh4KS/JCqArpM8WJfJRbuHYgObvmkthB1ZWmzQISB3zKoMaiLlOBOiwEEtt2GfMWJ6JO7Onc0PDDH0M5YwMjJDNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLBN1wfhZyfg4YkOeR6cP8kKZQ9CqftGbb4eqzjDY/g=;
 b=mCP/+8iEiDGG3/cKIA9lwM9bAclxvo87lyyqmp8XPexoXyNwZAcXcufDTgjhGp9o+wOzyc6W6Xb0CwBJAMv5/ZarX2uqOif8OOJLN8wK7Y2Z3PFAXZ4tn3cNQ8t/bCICHeTZHxQ13T6MEID9ktWRdzDkYxpiaTXufSqduXgvgm/x64JeCD0ei7yTjstbbSBarpFlCLz7Bm6FQjuwd+QTewTnyNUQBLnqnBvou15BkfutjMUW622grqp1UFV6cZd4E+0ELMsmqy63kLL0jegbzE9ZIFEilRbO+aFZsLxCN430iM4DnL8hoNxSZ0xrWbs23MmlHxI4OfZn1ArPB7TSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLBN1wfhZyfg4YkOeR6cP8kKZQ9CqftGbb4eqzjDY/g=;
 b=KJh6d7LxgQmtAwE7dxUiCLQhtA8cQS9MFjkm/1xXrQidaLSxl3QFwCqGqD3VulrvNRytcgAiPjKFHggd1HCMLYmMdReN/esbL/zXm4siUf51mPDBQjR3rrg51618TZFfd4jPjTU/1nEkBdigmNe7zes2MWU9r+T7AO09jlfJmntCuMSiEQB1b8JbdhJdNiQAaxSPqgbdJSyeY5pXWOcudVFI9XdXRuAKIsYNFVEL38wxSlDoMqiAeLeQh+yT4Q8fW3leIdYfwj9Lo8TjOgiBRzXCEEkgmRQ4+j98Vz/j1aN9QQWmYTyi4kIc7LjhhPJMxbvADujomY6b5Z+Rcf59dg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 23:36:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.017; Thu, 14 Oct 2021
 23:36:45 +0000
Date:   Thu, 14 Oct 2021 20:36:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <20211014233644.GA2744544@nvidia.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
 <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0444.namprd13.prod.outlook.com (2603:10b6:208:2c3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.7 via Frontend Transport; Thu, 14 Oct 2021 23:36:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mbAHE-00F5ro-Bs; Thu, 14 Oct 2021 20:36:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27a8f19-7f00-4448-2210-08d98f6b7bd1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52860A4ACE7EC4EB8733C5D0C2B89@BL1PR12MB5286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T9N5gx4xPynFJHYdWUIcV0VgMX6cfTChUxK9CryAfZvwUn6oDSJvXmdrgBAR7vjqdv589r6lIlXPsD4CHw+YsVxjYrX6k2ZD+S3C4LrlCRBIc82eioQzTDrRTZr3/jrteiJd5A+NNfX9tTaW6dd8ICGmBJj731MuTuUC0HO1879R2p582mwzvJft0yN6cHnWr3Xob+1+B1AZvD55WmSinoZ4VQBCi8bpgFKsOVdWxpKnaJ5UDHcezleaJ6loHzDH/FctWvYrLxHirtEZG9VZ+y7J1X/VijkpJmvamYVP9+z7Ece9UfHa/tvWnnszP54bUFl0Ir1Mjml2oKEu1N7Fll/uRht6MbMnVekcA1sHv+fLEpJ3UxhxY+NvAQNDI+w0ooWGpLerCoTO6aKJnzOCLvZszHGuD9/r3XLpCGChYzKUvxRoZdz61RbSMRi3oouKJUcHqVh9tgGMWF4SsbAnhiKuc/FrjvcQUkLvIukSUHLgKNVvOIFzSaFFnnnrX2O1xMUYmU5njHdaRZ8golMvU/PYEEjgiN7OwhX0KR9NrthxiJTgqzT/lqnszcZPshFuMkEgSYUt0q99VaKj//3EbkW4iYUAkYPdFqawJc8miR2BwZsSFHOj8lgYZV/W2DoNjwz1e/e7Me5Eyd2OK7YyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(508600001)(38100700002)(5660300002)(316002)(8936002)(2616005)(1076003)(66946007)(2906002)(36756003)(9786002)(6916009)(66476007)(186003)(66556008)(4326008)(8676002)(86362001)(9746002)(33656002)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMBV+aL3BXjJXh0iA8EVT7SujQ+4Dx46xoj/obm3svPVdirbcml9IZbycgkQ?=
 =?us-ascii?Q?vlZjcrYv/3ikTGzloyU9JS7qvAF9WaWII3CeDiA7ur0Rrq8M6eoxOWgJUtU2?=
 =?us-ascii?Q?XVA/SeL3TsnmWoiFX5a1+tjiCTrgT1zINQwkZ0Ha7d6C4xENU2VopVri3yKd?=
 =?us-ascii?Q?V5TrI42oqnis/OnSSLdI/6CXxaYodTuqqMAX8Cjh6xZmskiIJJRijT3mt4+L?=
 =?us-ascii?Q?Xr3551tnoxqaLaPQ6posbX8xkuXY7EIy9XaktjsVpl+yiou7Rb1KyupwY0rk?=
 =?us-ascii?Q?5dP3lS3JKgJvI4y6oE1Vvx+Ef39Mterfe0OQ/azQarfADha7nGrA4SJM92kI?=
 =?us-ascii?Q?ZlEbTH/DUtSUcNeo4TUEf8PBPzpLqMJPTsyW8JJp/CK27MixzJERD1D4r8jP?=
 =?us-ascii?Q?whs4Ik7UygO0rpfQAT5PWIpxHbbE65c4hp5mMvyJGTBWbyEhMS5al9w+Re6z?=
 =?us-ascii?Q?LK+vWpmQZ+wocROAXODzz5DfQ88a1/fgLRVUIkjfK3WdW/G8YOVJfyJs7zFT?=
 =?us-ascii?Q?SfaAy77SWogK1QGh9u+JwbKLJtO/oqQTfaZh8EVP+NpXXXRhyeQPnCqUtUcE?=
 =?us-ascii?Q?oi6b4wFok5iMyqDspU+5QnVYn3MkfG0sVTbZ1nzXCbpTi1zEIDdAvpN6dRgD?=
 =?us-ascii?Q?3ajFPiswnuIxsiQeU+Efxp4J1MgR4H22ZsAhT4n2CXZM1fYsXkK7ez49pXDs?=
 =?us-ascii?Q?i+9A4ZBCKv/CK9mFluGsUeJ5PYOjjexu2WR+xAszdE5tkJYZquYB7svkjD4X?=
 =?us-ascii?Q?c+ZZcHJ60pkE39yeX7yT79IL3OfzB7jQLnMnwsNPvVJxl7GMkTlK9d4rWqDZ?=
 =?us-ascii?Q?Y1Brc6H7V/EBR1POI0qj/i7cRi/dxCQBuO9EW8sLE9kAJml/I+ND9t/RN5ua?=
 =?us-ascii?Q?d6IhEXRfz5xh8y61wipuqWp+1BzsU6kC3N1BgsI7S/I4/I2Vk2l7OjbhI8AV?=
 =?us-ascii?Q?Ms737DiQ+3agdw8REFTpHPJu/HDYou6qljsTw2Qyi6qtahShgu6GVGmJo7g9?=
 =?us-ascii?Q?Rfn++USFzU76u4ZkcwbzYzHfKuLZ0pxxYzjnYujdG/WO0ed7QIDqXyd0XwFu?=
 =?us-ascii?Q?kCHI2iSev1WTrNycv4UI9C1NLfdrWLZ/2HajJIXX6A1bd8odSh3/9pRWeofH?=
 =?us-ascii?Q?Q0oLj/RQwQzPDt3GCildACZQE3omih4yH7o9/kyJejs99ibPrL47FBwY/S14?=
 =?us-ascii?Q?oD8Fz8WnqHjWfp7Pb3o6BRU21S7ErGPjVK5A0stQpikJC/9ZYuUwm2MCDCoJ?=
 =?us-ascii?Q?7ErKMOBZHcqlsSW1CVvj6OMl0y30x0X0rCYvdetpjMeGj7XUNIL7GvzEcOz1?=
 =?us-ascii?Q?kXKMmGFfMDavu4ht9HA9euIJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27a8f19-7f00-4448-2210-08d98f6b7bd1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 23:36:45.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uy357qoHfGVobDMV9brxTgQnChoQzExGTebFfUgIHbb+gkM+qLz4f1x16JF78Hi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 14, 2021 at 08:11:25PM +0000, Nikolova, Tatyana E wrote:
> Based on the following output, it seems that some systemd services
> won't work. I just tested with the port mapper which worked.
> 
> udevadm info -q all  /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
> P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
> E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
> E: DRIVER=irdma
> E: ID_RDMA_IWARP=1
> E: MODALIAS=auxiliary:ice.iwarp
> E: SUBSYSTEM=auxiliary
> E: SYSTEMD_WANTS=iwpmd.service
> E: TAGS=:systemd:
> E: USEC_INITIALIZED=33683420

Right, this is not an RDMA device, so it should not have ID_RDMA_* set
on it at all.

> If we need to use the aux device name in the udev rules, then I am
> not aware how to get to the aux device through the infiniband or the
> pci subsystem.
> 
> > What does the udev debugging say about these ID tags?
> > 
> > The SUBSYSTEMS=="" is the right approach, as shown above for the other
> > metadata. If you are having trobule I'm wondering if there is some kind of
> > kernel problem creating the wrong sysfs?
> >
> 
> Previously I was using an RC1 kernel and seeing issues with sysfs. After switching to a GA kernel, it works better. 
> 
> udevadm info --attribute-walk /sys/class/infiniband/rocep47s0f0
>
>   looking at device '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/rocep47s0f0':

This looks like the problem. For any of this to work the infiniband
device needs to be parented to the aux device, not the PCI device.

mlx5 did not due this for backwards compat reasons, but this is a new
driver so it could do it properly.

Then you can use SUBSYSTEMS and so forth as I first suggested.

> diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-description.rules
> index 48a7ced..9a18b67 100644
> +++ b/kernel-boot/rdma-description.rules
> @@ -33,6 +33,8 @@ DRIVERS=="mlx4_core", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="mlx5_core", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="qede", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="vmw_pvrdma", ENV{ID_RDMA_ROCE}="1"
> +KERNEL=="iw*", ENV{ID_RDMA_IWARP}="1"
> +KERNEL=="roce*", ENV{ID_RDMA_ROCE}="1"

No, this is matching against the RDMA device name.

The other alternative is to replace this entire file with a C program
that is invoked by udev

The C program would use netlink to query the rdma device properties
and return the ID_xx strings for setting.

Jason
