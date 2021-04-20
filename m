Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B7365851
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhDTMEh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 08:04:37 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:63711
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231840AbhDTMEh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 08:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPRpzJjTlGaSmKheXL+g5k1zjQeNQAUi4VPc3tcg/s+F8H3yym29ZGFpy9k0yFyucaA+uZNMqG2KoK4wNiUndSFmXOQkxdjDgydobh4LyU16G6RlikPFEILQd9O/RQROaOFBahntt3kjtwWdrQkpYM4cIofRDVVVzDwz8znUnQSBn3VynN96lRl1RlwcW26VNq/lPyDOajkqxOVx4rV7fI40evrxNnFLT2VhdDvK9w5hcqqJC5bEPnHHWyUWj6Ewdm2Ga8U5vCWOCIl5YkpnX9p63hFfVQwdXv7Ubf1jNpsPjg8wrq033uibrkQXtdSqDTypT8Dn1dCM08X717t2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx5U4jCIUoGdVhYxaUzYbE0219aOZ1r4TBOKMOrU76w=;
 b=Xql6eGco01lJGSX3NhQgkvlLlOyQo6Nes3CgjaICPIiQ9usDwdj2qElLlCH2Gs3Plr3KJLX2Qm7gSDNHwjsXFBXEtVnYeB5Czth2XWK3VOc4vZujxYPeht6RXRaXzlcKogf+ASS5e1oVunQo+/iN2MjDXHTspBpjE3yR8Nc7WA28UAcMGoOYBWR/6kP2pKaSkeO3cTxxnsKvufJrSIMe8gwGH1+Y8yzc52koGUfPtPL4EPdJLJ/hVNZ71kwCIpO5TbTAMGEccdGXf730HuJ809H3C88LMGeyocuXS0LHWAyA9XCgyKvW0vfmYtoWYOI3q49HqtLsibkShlbPBwAzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx5U4jCIUoGdVhYxaUzYbE0219aOZ1r4TBOKMOrU76w=;
 b=aiqN4CBaVTeAV7eSJ25RiSAZTGV4Om/MgNg4ZXoJyId/FoXWSJIUh7J2rJpk27lkRnpOPWK+8mvK8/fR2Wa/LB1BBFSinvNKe5F4ZnjuYm/69IO+lJWhDVuC9d/wSSpSIu9rj2ye+7Wk97E5UzLcyRLJ6er97sKlel2EXNiVFgjidtzl8S4/qtP0ZGzutXh1/WIeXB9GfPw8oP4k8MJ5FR6Zfv9zSVEsRHLGrnFFerMk7Kc+hgZqYQ14rf4IOHWX17UZezVz5xFmQbMztazLyK7/ByRVeIe+rZ8B19/do5g2AO7Dg+PHD+dyfjw9pOHVpKXvHe4jgBJ3b3bRV3AHbA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 12:04:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 12:04:04 +0000
Date:   Tue, 20 Apr 2021 09:04:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2 9/9] RDMA/rxe: Implement memory access
 through MWs
Message-ID: <20210420120402.GY1370958@nvidia.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
 <20210415025429.11053-10-rpearson@hpe.com>
 <CAD=hENfnffpYsxVNFUXDEedcGJ5oq3x-SrhKT23Y=6wiYYa3Tg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENfnffpYsxVNFUXDEedcGJ5oq3x-SrhKT23Y=6wiYYa3Tg@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 12:04:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYp6o-008xZO-Le; Tue, 20 Apr 2021 09:04:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6da7cc53-672e-4075-41d1-08d903f46432
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-Microsoft-Antispam-PRVS: <DM5PR12MB258278264CCF9C94F256914BC2489@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbC5dsqH5PIprlg8+oK1yBpagb28A7zW31izNb0n1GZ/o5tGguKo/H5TJFsjBGefKMpx1kN7oeu4eVtdvfwttm7Xq9fFEK/3foehUbD7j/jN+qIxSb2T9btHpxGpFyZhDmsj7S4tu3LU3B/klcIZnUdGDP95ibOA0TezcnsKIN0SVgYpNzOEnvrAYkUDidP2I+Ul+fz8pEad9nM9Bc31NlZUGUBIOsmhfFAQKlqexIpBakmZEaocGOkrDRgNOFvhHxM7/9Q6HTiK3H2pkN5Nav0pXW3t1RDgYN5SYKQYSB/gA3tGkKfwWEFJQDV94OA4z/Pd85rXtugBhP7JIiNZe45cWPB+9gfUXIL/8CX+E0zWZm6I372yL/kgrXztlURVw2cQ//GAKqSnee1CxsUKBKCr4ZpJ8WKCOKCuXTTg9xFCshzn9G/JAo+UJzlNiNU1LmsHSSLWZ6YXiJi1O8R4bjlupCvzeU1t/ItfCvRT4aUkD3rUiHTEAsi14Q3WXODtrQiJZIm5UFDgpxmqGUplHsPD1M/oA62qv04HfWhi+RaR6jp+NREZjXwvESJZo7/cj3nJvXd8dcnAeWh38DVOKqHO0eLJvlhe8I8gOR0LDI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(66556008)(478600001)(66946007)(186003)(8936002)(9786002)(38100700002)(9746002)(66476007)(36756003)(1076003)(86362001)(5660300002)(4326008)(4744005)(8676002)(54906003)(26005)(316002)(6916009)(2616005)(426003)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ffQq60SxOjZpS2VBI6NjK25PkQIrSvB7UMviWM5A1EZM3LDdlAuCuNA8+kzE?=
 =?us-ascii?Q?8ASjsdOvweTSHPd+JR9M1Kp4eTVMvoSScVBpYqYu1+Iq8Owxl2+kjfH/hkH9?=
 =?us-ascii?Q?SHb3FH6o5TvgKIa5uczQt0K7yn9EwRB1TuR57Pn9nsRGNekU2FP7YhCWXUUT?=
 =?us-ascii?Q?TuqARzsggm/2Wv9DM7xQ/sgH4uCI1EKGaTpl12+SyEOOs8jGffGXpmMLqolj?=
 =?us-ascii?Q?2srZHDhNADbbv8Did9yqQhjivTT0qRF8XHPhmC3JMuGBE7+6l/Ug3rUUTyUA?=
 =?us-ascii?Q?neRJIJ08JVndzEOrFQuPB2dQc8neY8qcVCj/3iVxvEjDDnQyonrWYr8TAveg?=
 =?us-ascii?Q?KzFeqAbOo7nKxqxvnGu2OUdG8qUmKAuvKOmEOmWLzG0qJq9RHm29ErxViadA?=
 =?us-ascii?Q?gyVpv1iVU4QCkzYe3ak4tJ6SA6Fl2LmYpq3UvHIt628z2KwIhOz3jXAqrL3c?=
 =?us-ascii?Q?kNqTxu/7MfI0WbW4v5t6inEp7VIB8afLb7YjBzO/ewQwQni2vWSSPSzhk7Pd?=
 =?us-ascii?Q?QrCyDXMo5a6c28bqkYQSXzTJYktuMivHP4YEKUrrTHySwIu2KCVaJf8EeAHw?=
 =?us-ascii?Q?FTj2G+CJ6hqykutNNWkpCi41LtwFFw7jHsMmAvShqCmVK41uGiRnZhSVvDJA?=
 =?us-ascii?Q?lMYScL8dhrPhrPpXzBCcr6uJN5f+kauR3QhuHVNVrW6kh1nlS+pyb6OTiQ0J?=
 =?us-ascii?Q?BfdzWVjJRRiHyh/Cmnvaimg1IpfR1GuWkQ9eyYUQXNdFIta8lfykPg1G6pra?=
 =?us-ascii?Q?g+K909vYv8RRhBIWlrmiGBvHzLHL8B/2lQnhvteHMa5IXH9kqGbO3KwUjd2o?=
 =?us-ascii?Q?GBTit2V76PyMsL+7PkBstnhVscg13zrgRBOXO2pDE3Qy6uraXzQuZbpDdU4z?=
 =?us-ascii?Q?DDRPjNMoOwsajGMX/0QgrQfo0HUkCS1ystyb/IbCslh9ufswwd5YZr/t+NyR?=
 =?us-ascii?Q?C6Je+y8iTXu/lsLvAbG4/6zmGJw0J8DZsA0JN/hQ8pGfd4Jx75tflRxajpqv?=
 =?us-ascii?Q?YOo+NZyWfuTs/I3PVwOCmLf4KQcUuXVMQqwchArk/FsgvSQg6x491ra05yap?=
 =?us-ascii?Q?Hy1wJpLXwcVmrWkhpR5EQTiYwkNnqSED4tJLdYZKGRynch4bflIpoztPhv8K?=
 =?us-ascii?Q?SfqcOZpz2nIFolxzIAgLS9ZEV4dn9g1CNh5rkJe3jNz0g9+lWVJ4PtUFl4UB?=
 =?us-ascii?Q?NkGwbruVsp7iJ+sv+b9RN8OdWemCiIQQsZgWnas1RWfAB7ocXBSIjMdtkkkY?=
 =?us-ascii?Q?6s/kqTBwn28KzmTNMcThzKpDzd2ZER7EeIl0vQCfOMVkKjYjrq4OR2f6uVF6?=
 =?us-ascii?Q?y6iekJBADqRF9egNw6GtYNXHYbUG+KDgqUKiAH36uNZ+6w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da7cc53-672e-4075-41d1-08d903f46432
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:04:04.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMfFJljGGZ1DbIIQfxYKnKya2N6Ud2LhGlsggUTK9eYpICaYVPIphFQ6UU0FK8GV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 02:34:07PM +0800, Zhu Yanjun wrote:
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > index b286a14ec282..9f35e2c042d0 100644
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > @@ -183,6 +183,7 @@ struct rxe_resp_info {
> >
> >         /* RDMA read / atomic only */
> >         u64                     va;
> > +       u64                     offset;
> >         struct rxe_mr           *mr;
> >         u32                     resid;
> >         u32                     rkey;
> > @@ -470,6 +471,16 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
> >         return mr->ibmr.rkey;
> >  }
> >
> > +static inline struct rxe_pd *mw_pd(struct rxe_mw *mw)
> 
> inline
> Can we remove inline keyword and let the compile to decide it?

Not in a header

Jason
