Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7E350587
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhCaRfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:35:48 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:6368
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234325AbhCaRfR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 13:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtNccxlVeAl8cNhCK7u5tK6ctE3/FQcWRAjmqfdgQdXyoGWXmyhHif1msOqxrbKknWHoxwqcfL8uSvctP519NfDvYcVxvr3M2Ay+LGSbw1NKYT6f3lJxGSChW/FSjZC+j3olRC/X6/xaE4JvwSdggrspBeMcNLgygs5dPCg+2vbKWpoLXitCWcnqeJNDnHk0wmC2cveyoWCxBc1B0f8SWazb3ms3wVEsWNOi8e9voWdgwkoJEDsIykragGziOLRZ0Pl1h9v6Ovbr3+MmhhT0ss1d9/jg4/2P5FP2xppwyFNNqk5sWgRap2SwZgJ+4LDM2wZItBhoXOMtjvzgUEdiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kh7s0jldvvDNiaNPMDgbCQS+X8SdVd4jf53OzCY+vU=;
 b=I+SzUhdC9G4loZTsojWsxqpFMkAx8Q18+fAQzCXMaMgZ7lvVaMJPiFu3N4eFTsiZ+4u7HUeykPy3Jf8k6NknNvL6/3WSA5qjtwDWNueGN6EF3rIeaqvLVt2kNd8c2YpOCLyUGW0Hej+J08A/63QYG/Du7QusxtlobsBGjfgAsSHQ+EtpKwukkszU/uflTR3PrQ0pZaYDJv0UREIJ2o5n+MNm27g93dIEDoetVUlAGvgyWp4XjLQJvRJoj5T2Qn1iKH6cR+mmezhRj5UnO8P6rOkO2MiGHUC/bpR88u2CxhM9oVXYnldxVwzbjIzRoRPJ2SjmID2Xr3L8Cl/G3nC4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kh7s0jldvvDNiaNPMDgbCQS+X8SdVd4jf53OzCY+vU=;
 b=hhcMmbvrd0mHgC1H88JckyfRK5Nku5lpQzMKeSjX1qr4KtrtXU8Y1vrHhiJCNPnDxetzCw/X/7YtgpYxInJgigZMMbDcR6cUZ7FkfMiXDO1YgTUnGpaGDTWzbEOmSGHQZVzQb2SdUfQ6SYXy+38kjuv4apJlk8+S5Cu2q20z68QQ55K8t8mGcg7TZrVom2kh0H/P60MtVmuTBXsRB3ZDIMHU91aD2CB2CZNHUTj4A5HAautO+rRpjW7igSu8kyqI7nPGZkC9VEFbfYsfoilKJCRmq3wXawBYWkxzky3wgZlln//04qkXDUo579GV8B+DWogxga/9woxLQr9RcaZgCA==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 17:35:16 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:35:16 +0000
Date:   Wed, 31 Mar 2021 14:35:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210331173514.GO1463678@nvidia.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
 <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
 <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:208:236::24) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:208:236::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Wed, 31 Mar 2021 17:35:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRekM-006P0o-MK; Wed, 31 Mar 2021 14:35:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c2cae81-981b-4d63-3041-08d8f46b58d8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4210D0B9FF03BFDD6AF5A3A6C27C9@BY5PR12MB4210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwix6RHDYrlhvh/6HnVzrkwfyyWHSapBe8aYUnYRUwu8OaNMd1qgy4urKBjHZxO7DS4W5Y1kO5LBaB1X7cxsQfqOCDOUcCaLQLuZw+Ya6/UMJwTNnqKazdeRAE+pRPGliBdyeuzD/NOMzpH720mU4jX2e05qMUNfbJGsMICZtSl6KMJCyEz7m5i148IXnQNXoOceOoRlC2nTiWvvc/bc8Drpr+kFmqsAKWJC/SuZlIyKUH+pCx/tUkhHllX3jIYHAL40dxTdeK/fAeSDfOtXS5nLrk2iXqr/X+h9pKoTvhqQsUWNlR6FNSQmaodcxw0we6dn3Xnm4EyR9B9YnabH3oTVtDNpFUzXSQBtAdNm6/9bdva1Xr5WFxkZjHSgu4E5+vE5oB6WMUPfjHGo+fi+B4hFQBW6n9K6pnygDoLwI/3CGb9viHuGYhsvqenAPQZnDkkcCKOPMW0rws7AsFIAcC+Sp6iQa57Tt9+zR6mhlPaITMYqvtitp/p6iffRUIdcl4JmmEt3eSoFMGwv+1hp8yvwL8N2m3K5U5SpczOGkC96rb6+VpVYZxGRH5dTptiZQP3g1YSrLj+kTbmaDB5DUQ+dfDtGABnLQIOqPISH/qgPrEBcmaRWqaSkc5OKJu5FO5RqFjkrH4nMfRBlA8Uz4sLLAEHWTHF6ZXY4YFmuLA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(2906002)(5660300002)(1076003)(53546011)(4326008)(38100700001)(316002)(83380400001)(26005)(8936002)(9786002)(9746002)(8676002)(66476007)(66946007)(66556008)(2616005)(478600001)(86362001)(36756003)(426003)(33656002)(37006003)(186003)(54906003)(6636002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k5raH04e39QgDgmmOeCyp+h95WPxffkZiKO9VJtF4Xc26c1NyR6U6qwao+Dv?=
 =?us-ascii?Q?8jxUjls0/MziDVRSyxdWAJXn/ofYC02AcBYYX3RCR7R2FS3tIon5TuwQBL7s?=
 =?us-ascii?Q?LM6Dtr1eclHIHKA336e53wmRogcE76W5PoZNr3e4J76Du7YLBHLFCjI5hV6d?=
 =?us-ascii?Q?vjoAICPjd00BaexSkG8z4R1m1AioxhLTd6zfAw1pdCsfrnSbxHHLXnowib/g?=
 =?us-ascii?Q?OCTKJau1ZeJPPJA/YHjARSCR1R9LfRtkWRONJq2P7X/ZulrUjuGllXi84Eqk?=
 =?us-ascii?Q?BsM3I5crGgvqVGBZb6rn3gz0Xs78Na1nHfokL/qJmfTYqWrcfmRKgBd/+3jX?=
 =?us-ascii?Q?E8dEJDnO630rhFZpXvMfENOSK0dgiQu3WBp6KMWeiF/xOW9YWNPRVaLKTfdc?=
 =?us-ascii?Q?EnsF5HiXhPgj4E7V3syiUWGP/+jQa5uzOu7M1+712agg9NpZlmVWAFnKzH2e?=
 =?us-ascii?Q?qeS0OIQ0Ab4eXKt9Oj5amEDC27T9IXcfmmKayUEwiXMfK/rDN8jacUV+4kYW?=
 =?us-ascii?Q?39fWc88wbP9CIgzGJHNjlB4j0ynmvPUYsicTtfjFILBDJjwVDqySWkAJq7r/?=
 =?us-ascii?Q?tApNbRO1unFLwtMTg9gDwu9p3N76qErFU2f3b/4kE2ug8Iwc4D7sYDzmGLNU?=
 =?us-ascii?Q?ge7si4ALbIDwO2rkdEFiN61KUCn/0DuX4Fi7Ql23N0jaaqr7n+Uf0n9SguSC?=
 =?us-ascii?Q?B/s+8kU+0Bq2Ga9E+TzTgp0S2G866MFpn+eARmkPm52eO3oPN20jd0YJz7lw?=
 =?us-ascii?Q?T4sIIV17hTDRD7Lky3NgJNkAMDaw0bYduKIzg06Enxr6KUix51XHluFR9rr8?=
 =?us-ascii?Q?3wUY+DfqInhR3J5CmHIYa9a/CdYZ76HeypMWOEbt2UWb8NJ7T8NiPy92C0iS?=
 =?us-ascii?Q?4wKiqDE8MUU/2GKClNb5wtZYiqCZ3ZAB7LPVO6UjHWasWtTeB4+5+eo5ppxv?=
 =?us-ascii?Q?V2Rmo9ql/vAifQvWxcMsSab8mSxJYBdquigVXVZhoFblIbmmIkviBR/i1R6K?=
 =?us-ascii?Q?+jib4ZtOWuBk5jbqeE3XF5RZojfTgImBCYfap9xAs/KjEXzjajbTOpdSUDAE?=
 =?us-ascii?Q?IkJp4h+wIKnrHkdFQOc0wM8hGM10qCXO1Q8kQpnTAj/4NrE/NxRa7yFu/fUh?=
 =?us-ascii?Q?l07TK5zfTTi2Pd6EAYGR/ep0W7vgLYyBbQsWoyEliEaWlotGxLeZFwuIOkkC?=
 =?us-ascii?Q?L6tI8HTiGEAE5vvr4W7vVFM5lBEyFJIxu1W0Kp6DXFfI59hGC6reYpRc23kW?=
 =?us-ascii?Q?ntiJVmfGp5VJQm4CB8okf/SZHCCZVzS2ZnzhZl9VUCdt/eL7Fyl5kQiB6Bsn?=
 =?us-ascii?Q?ScYkV0oJaZp5J6Qr70QCqIHvbxtEHhjF2pNfPzGXpEn5vA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2cae81-981b-4d63-3041-08d8f46b58d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 17:35:16.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/zyMqUVyegdEBGBR1SEL1LTKx3maalcMwFW86aSJQ7LeA31QehvIgaXOjaO+GZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 05:09:27PM +0000, Parav Pandit wrote:
> 
> 
> > From: Haakon Bugge <haakon.bugge@oracle.com>
> > Sent: Wednesday, March 31, 2021 8:20 PM
> > 
> > > On 31 Mar 2021, at 15:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 01:34:06PM +0000, Haakon Bugge wrote:
> > >
> > >>> Actually I bet you could do this same thing entirely in userspace by
> > >>> adjusting rdma_init_qp_attr() to copy the data that would be stored
> > >>> in the cm_id.. ??
> > >>
> > >> This will definitely not solve the issue for kernel ULP, e.g., RDS.
> > >
> > > Sure, that makes sense to have some rdmacm api in-kernel only
> > 
> > Let me send a v2 doing only that.
> > 
> > >> Further, why do we have rdma_set_option() with option
> > RDMA_OPTION_ID_ACK_TIMEOUT ?
> > >
> > > It may have been a mistake to do it like that
> > 
> Timeout value goes in the CM request message so setting it through
> the cm_id object was likely correct.  This reflects into cm msg as
> well as in the QP of the cm_id.

Ah, yes if it goes in the wire in a CM message it has to go to the
kernel.

Jason
