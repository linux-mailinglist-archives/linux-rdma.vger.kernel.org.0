Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8C39DC76
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFGMeG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 08:34:06 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:27073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230287AbhFGMeF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 08:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYINLAoUfsNYDpdFWNYF3U+r1Mu7ahOA34pIT5hHlA9+Y6yTZcrUfCILHQdlG/6Fw3X7qGnJ5DjDvMdAhFZ3jvdaJwvYROBNbXXTP8OLX1ZmtVaBbMQJrdmHIqDahzlx0LVEeoKcdUvnAV4xmzdIydbco9r9m0wjSfDvgik9GEhCyzpE5WrmMggVJB5IZB+gFe+NpfFYplcr3UEiXz4mX8T28U/R1s+K8gNHwf8Ve5ci+TCnKQq8wl5F+G2rdScS08jIw9z6H+SYAyzJQxFGpzC4+vwaMfrE8JxkMUVDglj003ZpnFdkxdKXmX9fn8Ky89rtOUdfHFeJcs5OzLHC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arzYOHqftCjJOFZXQSnetGMxQYq8PBA7vZ+1AMD/T8I=;
 b=guoIGL2Po0WVXUfg9t+uDnHPhNe7jjYkI2ltCdxIauqqqe+hsowZGxkEwsRc/wV25GUXbrLvgjoWL7K7pA7ZGYz4Z+Z7eAwrt+5KKOHbrC45u3okltU3LW4WZ3da59MyPjWMpkayLaLOph1IQAzV/ix/8xu+s3B6OV+nU9PFdnvd0cPeapfMcUnzW6CZ94laZIynM2Rvb8dxxtIO1b5TRACS2T4y3uXK58McwGF0l6oYkc29ryFrTnEkx2OOygtM5YF3Gx3Hv1eerIV32Ppacpd4usfxpyzKlpdVivOoEO+M2IWivhFArjw9fCrgJc5Tdey9kZivSJKhgiFSNOx1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arzYOHqftCjJOFZXQSnetGMxQYq8PBA7vZ+1AMD/T8I=;
 b=hnf7mOoUwV8FiFGnmpHburDdfKH0Rnc37eZ4Kchw+2OlUS+dkVC8YZ9FlLdfPld/dhPMd/aTyj6qIyVcIKxKvSfYaKfbjPMBIJkud3C42zW8E7rq6yK/K1VhFsjghO3mVKm27PYSn2BekwLIO1Cz/Inqfv6V1YT4YtwfNipxVwCTHQrq8ztoHL1TB6s3QpKMPGZ/XqILRYyhpgHyfEr/2DvM0qPbn3rp62qaKF6z69MrK10wFEfxq5F2t8ZCshJqdKTgvhXTJ1jXPKjIRUODpoZ4U1Q2UsPjUTjW7+mArG78USCVmGsS38NcGDTo6sgGROHonh3vQaRd7gRoOSGafw==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 12:32:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 12:32:12 +0000
Date:   Mon, 7 Jun 2021 09:32:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 02/15] RDMA/core: Replace the ib_port_data
 hw_stats pointers with a ib_port pointer
Message-ID: <20210607123210.GD1002214@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <6477a29059b1b4d92ea003e3b801a8d1df6d516d.1623053078.git.leonro@nvidia.com>
 <YL3zmzSTJ8nE1yr6@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL3zmzSTJ8nE1yr6@kroah.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:208:1a0::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 12:32:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqEQM-003GcZ-E7; Mon, 07 Jun 2021 09:32:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d77f184-ddb1-4dcd-c278-08d929b04661
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB514303E9C26BF7E8CE9B9CD2C2389@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruUEEBty14SmyS2iBNGuNscR8CC3EMMBFC4yS4mHwVVABo9HIn4Fj6rIOZHS1Y84ht+LP6UtG3ZNSh67p3tkzy0WlwyCUELHdYJM/1o1h9aD8zjTsx+PwSvXdoS49cEJLztyn0YNcNARk0VMMdwdQtqmZ6SEkeOBVl4Ca036j1aC5S6i0dtg+aLpsaudgJt881PquGsa4ij0Rh8GcplZT3NaIqq4xfkaSBbBkeFANkdXrp286g+jGFo/je7HLhI//JBS3CFZ2yIfbl3vzANRUESEt02F7o9sunk5K3HwYY1nWa4fE8dZR13ZPNt549PmM7MbQ/kmABjmmnq2sDSRxwpudvbeFAeC74ZcSxOvz3bHxmg70uT0O0zQbw+1m1q1//NQyg61KxKhTlVjpSSVqBH2gFOpEK8ENiZQ8MWKROhgFlJVhqVa76N7mBx8+tBfzuHAUbvrutf1iCmu/Jsu+46f7ZB+SzsdvZYunZ7lauET3DHqppa5nUcy5Zw3hgu6eo4gnhuTP0dzfTLIVvaqkrrABMHIdm/LJYlTzu3CWpDOM+8qgKwrXDdQ06jcMkO7g7ZJEcHZ1+Hn3MkY9Zp+nSzQ2iDpdvWGFa+nkox7HI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(66556008)(5660300002)(66476007)(38100700002)(66946007)(2906002)(36756003)(8936002)(7416002)(54906003)(186003)(6916009)(86362001)(426003)(33656002)(316002)(9786002)(9746002)(478600001)(4326008)(26005)(83380400001)(2616005)(8676002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2nA0QFmCGRdxYfS89z6U3gf3pyuyTdyW5IRZ3xl6oWB7bvK05OQccwdKxiUk?=
 =?us-ascii?Q?XL4/N5YzgAhwCg/nsoHj1BlDdeEm4tX2wIthwmGeuLhiCwU0TrGhYCIzcLHb?=
 =?us-ascii?Q?810UMwiG8RnI9zqDtbbN+hfUSV1JspSYafucnhVtgCCc9U8eZj8YbvHbCEXS?=
 =?us-ascii?Q?2aSJoO8wIzlAPOf/xhHJkG71hdshIfjoyrUVouy6ztCjZaf3NeNkw/+lK/Wl?=
 =?us-ascii?Q?7+Ze1zIk324AyW7KxwvhV7k7qGzrQhGemzkdtR7sg6bHklp+Gb/dIa9LTKwI?=
 =?us-ascii?Q?QZk7CJuLdbbPIXves4x6708XZ8CIPuq6hycLc6iXWMlxTTjPk9bLnJqDOn8G?=
 =?us-ascii?Q?untFR4Q84GbYr5oNMD7+0r5fYK9bVNGu/eCJeeKDgwADU7+n9MY4NNOj9Lwy?=
 =?us-ascii?Q?3Xb+uovXfs7XlQAE17HAN23bjJ2sZ275MSOCpp4fMmuQLiPxpf9y1AdEJvTN?=
 =?us-ascii?Q?Athle/i9+THh4MYD/b227EjuM0+K3MChxWHgvkN6D5IomzdboJV9fmC5ToTy?=
 =?us-ascii?Q?+fpr6dTAeo3CdvVT+NTWXt+ayP8XQqOP2HEYPHtxyDiCle8migH0j82YkyiD?=
 =?us-ascii?Q?+FPt4UbC4kmSuL0H2WgOum21tearo2GbGd2cifa5+QI/sHtGULbTrW1U4/tT?=
 =?us-ascii?Q?IPsGTFqXIr3X+wT79joAEItRHOCmNE2U4eFNG3677kvtiimOEDfh9VaPH57a?=
 =?us-ascii?Q?Ox8FIFeLcBoaqfHwGZQDIJsS/moPjxaNhNSWY1lYYg6rpQ//rR0+wezXLi20?=
 =?us-ascii?Q?g0YD1leaTns5pooGvvQasZAx2/5yTs6PxJlgQj+DIgPvDjkydWcmyTD2TG7N?=
 =?us-ascii?Q?um5w8tT9NCj7kE8L8aXEvjWWLCg5quyAYu8b4L9UWwF6xh863GtRrEgWKikX?=
 =?us-ascii?Q?IMMs9V0JnOBc+dC843mFpaFhBBfuw+ZPLLfNTKpZOTmAd+02XcrisKHePBKC?=
 =?us-ascii?Q?AYcMZJSKEWEcRUnp0HpTfIiZzKkl90syMWjEePqM8E4ObUzrkYFQ5DYU21PC?=
 =?us-ascii?Q?ORS+2xDEUwDe3vs+CRZjDthRLucuJAAx6rLs+e2SNCFU1ASsoFhMCpqZf0Uo?=
 =?us-ascii?Q?JurRXM0kaLq9thmxv2rDOqFSdbX1GQSWxn86YtqB5wfU8NlFNwD04yg4CuDF?=
 =?us-ascii?Q?likEF77iML68aJibRA37qKPb3ULmKeIYUq6DCzkl5Z9zM4oqblyfql31qbO5?=
 =?us-ascii?Q?0IDSHKXDDSxHJwJK986DFO/n9P/iHoj8CimSxQEuZbuFhWp+OwAVe/RugqFK?=
 =?us-ascii?Q?nioBVlHoi9FOyL494949bZw+X/MdIH42ZHklrYFCErwiSs+d/Kf+5oMIponB?=
 =?us-ascii?Q?NSYAZlK4k9FJDdLNohHoJi5v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d77f184-ddb1-4dcd-c278-08d929b04661
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 12:32:12.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig4GZYBIwhxBUyEOcID6Cyc2mCkNh3Wy53QSJRSvXeRKbcgZWjXadQVsavtS5fmT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 12:23:23PM +0200, Greg KH wrote:
> >  static int add_port(struct ib_core_device *coredev, int port_num)
> >  {
> >  	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
> > @@ -1171,6 +1177,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
> >  		setup_hw_stats(device, p, port_num);
> >  
> >  	list_add_tail(&p->kobj.entry, &coredev->port_list);
> > +	if (device->port_data && is_full_dev)
> > +		device->port_data[port_num].sysfs = p;
> 
> You are saving off a pointer to a reference counted structure without
> incrementing the reference count on it?  

This storage borrows another reference count, primarily because there
is no locking to read/write .sysfs. It is a fairly common idiom.

You can see it in the free path:

		port->ibdev->port_data[port->port_num].sysfs = NULL;
	kobject_put(&port->kobj);  // port == p above

Due to the lack of locks the whole external thing is arranged so that
the 3 users of .sysfs are sequenced properly around
setup_port()/destroy_port() using other external locks.

Adding more refs without also adding locking is just confusing what
the data protection model is. This is a borrowed ref and access is
only allowed when other locking is properly sequencing it with the ref
owner's manipulation of .sysfs.

Eg I would reject some code sequence like this:

	port->ibdev->port_data[port->port_num].sysfs = NULL;
	kobject_put(&port->kobj);  // one for .sysfs
	kobject_put(&port->kobj);  // one for our stack

As being pretty bogus.

Jason
