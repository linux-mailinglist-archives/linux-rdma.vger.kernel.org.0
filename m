Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD83426D4
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCSU1A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:27:00 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:4321
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230409AbhCSU0a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:26:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DN3xao+QSx4N317twzqXJKEV0RgyY8MrFE4ytjJaKeGjaJDMy/w0aBqVEsdyZ5lTPOI48cJbv7HxAx0dGczmvfCVGAbpM++6dWk21a/U/vxujC9WZcixaXmfDi908hdmftJlNJMNqO1ldknFPmn1rtXDeSMD+YoiiPqP0uwaFsR4361QzuO53MOREMnQRtLofbyPQIUyfi9VBYD6c51oMTmUyDVMpLBJLjwr3Eq4oTX8jitXPmBjgqkG9Hid+dSAkM6GIalX5/oc9y+Zxl3YSLlSAf5UNq06wK8MoGvABOl7awwMLhTzDEIO9LgL04KX/hC3rMs9IGclFW1Ex3vbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifaDSj/vL5gnueGN789hqNkm7Wux0P1cZF7Wic8TP/k=;
 b=Shgecxv6JXVl2EY96SzJQV+3Nnd5KeNEJOVodX2ec5jzN/4fDwkC22tcmf+p3iNEzVzUHXW6qhT9mOvX+opgSy20T9QeRnbSbrfXrM7kGheL+Lp0m57rV/+/GBNIUa3psVGBr+iyUxCuBFxBCIX9t8yMxBRar8oxHEAjToJXsDM//IiZqxH337eP15xqeDg5kxhq/CW4A6gKQ4tCUGXgr2VTxifDI11eXAqmAFWV+ebEo54zrPb02Nqzy5K2zNhiHocTlOEmXHWvm1B+mZYoqnBbn7C6BREOoIbAs+yNx7T5yrxmZpHsMnokWHdAIjLuPHDYbvNUn74IDkHeWiE5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifaDSj/vL5gnueGN789hqNkm7Wux0P1cZF7Wic8TP/k=;
 b=gjyrUynLtRPghwwNSba8Nfr84gOUXo/sPFJvEyAPbHpzpNm1d7bOej1UCd1WoDGUtGCtIwkAOiSk9ApaEIbW7RCnedwRy6r9GB8LYJh6DcuMycaX+fqy1XdONSLreXkVcMhmX4gH4XoWEYl4p3lM9In3ZdPYDa+2NCxqOY3ltqouTYGxP1T6c5Y69kwi+IgdsnBdYeOAj9P0lqiW4WMvaNF1IblrTQiOgJBqptVLPqk80Voh0yyXJpyJVbilQgIl8HXRPdbMSlIMBjk543a+u5oLtVdbBWmvxhaHKBSk/sEOZVF4BGvVnI8NfU/1JeLTvmermIgfII9OMcOVPjIHPw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 20:26:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 20:26:29 +0000
Date:   Fri, 19 Mar 2021 17:26:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Rimmer, Todd" <todd.rimmer@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319202627.GC2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:208:1b4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 20:26:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNLhT-00HRPw-U8; Fri, 19 Mar 2021 17:26:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec18ecc5-4425-4e37-59e5-08d8eb1546fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426786F8E8AA6FFC98161135C2689@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: se87o5vC3iZD7lMG6Xkwc/ASL/GNk08U/7blQBZ0zN+Cl2u8qCTkRMj9KaXjk4ZLb8Br5PpFtdlrK5qDBwwaAEn1AgjmRzvexn+qgdrMOcU+eAd//rTNqMCZqHJbDGJ9gaSbayhizAXAgFzBN29TL9+nzXhuiBbNEfby4luA18f3BWwz3TR52LclXwg/yQbd5irY5bWb3WTDEEXFu8U+qjL0DTaOqT84yKiCPt4gOyM8RSNm4d1RhKrn3oIEuzI70MnPutoQXZkUCODBKmknlOsWAHPvpV7rRsIseUZTWJXNqDWSThBSYoJvAYOp1cPCWyCFtLstfFjqcpSeLvSIXJhtspMMw/gLN6kXBfdo9xiDAf1KJFdxDolYsBWjji9x/DzMOHzGZzzp/gDIv5YeUXXph+aGFr25m3nRIgUeivspGRB84xzRDS5+YCaPliC5DH4jV2ey2w6G86Fqe01QYNYN/dKXU3E+/EBAqfzjvQHUTnTkTkQt8aYB5OM7W0QLjjYm7q37LAtnamaZB7qgXEUOmsXrnZB218Q3zVgcJ/phRdJ9kOX6udMJJe3KT7755kO2dCIuRf1xYQHVo8vhFdBMH/4OG7sF+KhSvVy/bFPm37CrXMU/G4SZVAI7ZKUiBnJpRJ8rlJwEyKbu2PENqkGXFwwn1LBDuvilgiblPV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(66556008)(4326008)(2906002)(8676002)(86362001)(9746002)(5660300002)(1076003)(66476007)(66946007)(478600001)(33656002)(38100700001)(426003)(6916009)(186003)(316002)(2616005)(36756003)(8936002)(9786002)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1D95DJZLPwNVEJusvi3//XRlCoo8F27Pgk9bz0qSPSHSUvMqpZZsccabqP5t?=
 =?us-ascii?Q?xQG5eOOogU4vKcAxwoLvm2sweQ257pLF+w+P1G1R9jvruTMEptJOuUUKbr67?=
 =?us-ascii?Q?CgITMhN9+eVszvLAVZiX0gXsw7gZ55ju0jgnSHsLyh9S0dYwCAywrcIg10KZ?=
 =?us-ascii?Q?36jEuLPbO+YY1FMYDYPeZNcxIP1z5xogwy6961uGbXIWqNSTa9AME0CTklcK?=
 =?us-ascii?Q?Blt3pauIGNIrMYFjqrsZAFqqJYOHYdgSwBMxMDSEH69ZHIiJBBgzYI/JkqQH?=
 =?us-ascii?Q?dCGg6cQu4NN1fzHCS5uxKLzg4EgcnMgyRDwfqKuLnMW9Nusgbfk5eCt+Nbg6?=
 =?us-ascii?Q?usUGldjucPnKvT+UNEfQmCjUF7hSCcDRwA9GZCuICbY9vF5fVrJim6tU4rAA?=
 =?us-ascii?Q?a35nvttSxecRqJ3xUFL0aMZ5/LwZEu56t0FkvXX2VDv5qdsSrMX5Tmn9BcwD?=
 =?us-ascii?Q?jqVrV3+TD1ylX1FO1fnTlFFEDe15hQKRAjNXJLgCi1uDlfGsBmR1sHtjmSsS?=
 =?us-ascii?Q?ERxq87RjHRLrOvGauDKN/S8bY7dprom75lizrI2d4glikfle9OioAypLPhmx?=
 =?us-ascii?Q?rmc3yghp0bUkTdcnz1f8H4I/iH72wYCCZGM8+NIcQXxDvW5875QMAVXOpyYX?=
 =?us-ascii?Q?enlC003kUo16PJZw/dfXd4yu03Xwok0QrG0gst488CiEIJcqyVRFZoE8GzDO?=
 =?us-ascii?Q?eWW7ZgIxDFrTKbfqsYc8N/GyzXOhMzzZWDF9fMabQkwCzsd/Mynn3XlXgDF0?=
 =?us-ascii?Q?fUNDQIJB7ktT63iISq29Y8aBZQh5OitClVOb4yUtVhz/LC4cM2j2q7hbzDb4?=
 =?us-ascii?Q?Qb07pDE/nNTwXMqUftL8iwWjwcYQWS/m8gXocF5wyEKYEfs7kMrr4omMdYRF?=
 =?us-ascii?Q?zlPKiHzEqkjSG9pe006i7YI6EKyqaBYOHsyrayUQ81FaACw84yCA9sWrlm62?=
 =?us-ascii?Q?zEWMNsuKqt/hFZ+y7Mie+rhi3jDuQOgxUpflrQQiNqwUDXemAWTq5maMqflf?=
 =?us-ascii?Q?x6renYXzfUM+EGEbNQN0dwbOn6OG9vrverKfsy6b/jAKN0z8vIb7l9PjNa+3?=
 =?us-ascii?Q?LplExRbh9YKFMO2Q9edtcAAJeMyKsZVYSf4ko7Cix+6eJjLC3gMt/RZhlRyJ?=
 =?us-ascii?Q?uXjX7Gvvqr/JXkBpEX/M5YQCpBCOr19uV6OFhlA+dBgnsSqFdojBAzmtwfcw?=
 =?us-ascii?Q?6NcUtvegfA55oCf7Slzn3WErWM7+bci+zZz7TEIBRaD9mPL+3zy2rw1GYZLb?=
 =?us-ascii?Q?CYoRhvkCWW/mPzY9n81PCsNZbZHDwFbtpc1c9UIal23slc1eQ3XA6rvuYdYK?=
 =?us-ascii?Q?iGMY8EBodOietSxBPSZoRqKq//GQ2IEcRxMIvYmkV4wDHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec18ecc5-4425-4e37-59e5-08d8eb1546fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 20:26:29.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPqb2WjfUvWJYsBRUJ/Ssdwy7FvlyCjslpHm6PLE3wlO0eA1EsQ2BXaSW4El9Bbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 08:12:18PM +0000, Rimmer, Todd wrote:
> > hfi1 calls to the kernel for data path operations - that is "fake" in my book. Verbs was always about avoiding that kernel transition, to put it back in betrays the spirit. > So a kernel call for rv, or the hfi cdev, or the verbs post-send is really all a wash.
> 
> To be clear, different vendors have different priorities and hence
> different HW designs and approaches.  hfi1 approached the HPC
> latency needs with a uniquely scalable approach with very low
> latency @scale. 

Yes, we all know the marketing spin the vendors like to use here. A
kernel transition is a kernel transition, and the one in the HFI verbs
path through all the common code is particularly expensive.

I'm suprirsed to hear someone advocate that is a good thing when we
were all told that the hfi1 cdev *must* exist because the kernel
transition through verbs was far to expensive.

> Ironically, other vendors have since replicated some
> of those mechanisms with their own proprietary mechanisms, such as
> UD-X.  

What is a UD-X?

> Kaike sited hfi1 as just one example of a RDMA verbs device which rv
> can function for.

rv seems to completely destroy alot of the HPC performance offloads
that vendors are layering on RC QPs (see what hns and mlx5 are doing),
so I have doubt about this.

It would be better if you could get at least one other device to agree
this is reasonable.

Or work with something that already exists for bulk messaging like
RDS.

Jason
