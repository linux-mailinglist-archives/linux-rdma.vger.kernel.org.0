Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B175358782
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 16:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhDHOvk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 10:51:40 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:54864
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231370AbhDHOvi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 10:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDL/EN3ShMqNtQkLVYAkZdWGuEFOTiaS6bLsDk16Xb2ukaQZbq4z2lDimJeCiuTomi7SWViHqyosYe2Tj3ziErpVVeksQG2nb3QrSiugDvA0NubvHJBdpZ2uM1/RBy261cavOk9OU3J13cr0y20Ca/Q65lNMaHgnO58+nI8tsfjlWME35S1l9emKxM4EJU+P3T2IOugN5+a9eim77zQ3UXYIqgfuRx5L9LAy1iLY8bTXGDaf3AsoR76VbLDW92EzTwlirwTW8Y+9fG/FHpbHP++i90VRD/WkuRHkrg0kmxjTCWhZI4LOUQhfL6EXpLkNdOtIZLKbaEHQEnD6AjQa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WfxBIijH7FJnO/iCQ1k/58+1eNv1+99fWAeSwDF/Bk=;
 b=Mk+DNmoFE6G1NEZ7yCkWdWNbOndJlLIxdfsgvl6L34qs2CdwmJqszIADhy7hsBci+dWz2zfi8loy35TKQRHIxUFlQGuZMQGR3Iqlyupz6QHIFAFg60F+NrSBVEtWi6xhEufk+n3BXOAh2kj5M98dV8ESTakmMJYNh6XEFxXKq7qwxCUbQI2Mhvzm/P0qEYttUo/lJXlxbtfARGR7q3n+r6PSj0mOvpeZSm9It+CAzrGKHDfERu1ryuurqn5g3KYzte2D8wRRW9nOCctwCJR23Xy4HRGRDOPlsDzaXiRQ+vvRl1mYkyBUMTLSgVswBBOMDmEioISVA2gpEIY3jW8fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WfxBIijH7FJnO/iCQ1k/58+1eNv1+99fWAeSwDF/Bk=;
 b=qGjLNZOQEy+rWxBISoYk7ekXGDOAcAjxDqTMp22Ru2kXTlU2pWZpzYLzeYa/0Ct79r+kbi05UlQ5UmYt15eu7tuJCsIufzU7SsXnwqll+oluCq6S+jAH3JphJDvQN64V41CdMSyRNybXkP9BXi6tTJHN1Rimaydy5YhPN+JIh44ea5Ocb/C0vc2v2mBJlCpT04scflEn3zijibACri1ILawH4FN6BN0i2HhzGyRFyEsSBm/CvddiXzvc6oAQhho2bqtDUxtVjF8xMsyZjU5+MqYIUEKuwN3t1ny6Kzm2qH2khoslrPS5mgIkuGA6phzUDj1n/Ilea+SijNvUX1jdjA==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 14:51:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 14:51:26 +0000
Date:   Thu, 8 Apr 2021 11:51:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
Message-ID: <20210408145124.GU7405@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com>
 <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
 <20210408120418.GQ7405@nvidia.com>
 <CAMGffE=pu7uhmsBaYBuZB2w+YOogrK+W5yEKRPZxTanx5+f0Gg@mail.gmail.com>
 <20210408135033.GT7405@nvidia.com>
 <CAJX1YtY2d6YHuDZ0Wbg+c33yoaoCa4_iO6_nT3Krb3uWZFfrag@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX1YtY2d6YHuDZ0Wbg+c33yoaoCa4_iO6_nT3Krb3uWZFfrag@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0057.namprd19.prod.outlook.com
 (2603:10b6:208:19b::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0057.namprd19.prod.outlook.com (2603:10b6:208:19b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 14:51:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUW0C-002l4h-Az; Thu, 08 Apr 2021 11:51:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 657c350b-f606-4bae-fd1f-08d8fa9dc8c9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0106D7A5518D330E7FE7458CC2749@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1kgz6XJa5zwqwazUg+uoxytpy/moCPPPjKggRmvvOUOA4l7nUjwjECO54gZsytkyjCff+8j3EjvK5uvRNP3fc4fvoDaFw8puH0JNautj++Vt1jlwHCbC1XZ1Gc6TytFC0Rq0Pljyfp6IWo3YQrwDMVCmdGfwEI+95eu/IQu4JvIHMlgFiQ3ACdSpJ6lP0GhOqpy6z740XA0GIzQ/KaXBzVuJhcooUOonAYbHXq1nEiOcwvbR+DF7FRQ/SDXNnzPS6YNYajasjE1CN5BwRrS4FgXEjBqbEPpqDghJLtkQbsAuAy5EXtnouQKkX23r1Ha6T8UVPF0Q6S6PCNB5b3+vrKBebgANrjqdxQC7prnew8+K80LeDG3+GUoCUdI+UVx7mPlbPk9ddHt0C37Y1aoSn2yCZWEt2oJgRZzdqeIdYR8ecae0VXFI21YdhtqxGqkX7cpWcrR5xjqEPVEV8jctRBLCCeIYj0tacPzQTf3/mYiCtCRzqnoLGg04h184rub/iNUOmd/f2NKbUiGKxTZWXTVAgD84/969xXgIUP8V07mrjUr5Nx8I0jHW6aQXaPP7U0uuIMghkbcol5wuuyNTL7nU85MdQdM67lLml9944+YpJurxRJfpzhuEcDUNzk47NcCJQmve5JWkSs3H/T85X4igxqKBadTU29gFAWAlwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(8676002)(83380400001)(26005)(66556008)(478600001)(426003)(186003)(2906002)(2616005)(1076003)(9786002)(86362001)(6916009)(66476007)(33656002)(316002)(5660300002)(66946007)(36756003)(38100700001)(4744005)(54906003)(8936002)(4326008)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k/2afpJQLkMdzHG0uRuPvR1Rsgf3bmZwfnb2uzlv8NcGkiPOY78QdCNpr94L?=
 =?us-ascii?Q?apsGI++7HVD9QpAlNJgx5VMl49HRqd8QveEfGbPUcF6u7eyMbFq+02p+9ZVx?=
 =?us-ascii?Q?qAezOi58ITrPYmDQmFOtFWIsq758BnTAOndqbYOalQnjjDCN4VNgsnUnmnf0?=
 =?us-ascii?Q?MPFA8rSqR72J/XDasnEPh+LN0rbdMrKMAPgop0JB0lrhAAZzq3ukIzOP9oGc?=
 =?us-ascii?Q?IsXZUIcG5OnYIPyi2GiAR2WDeX2s1ErW8y9mFZca/XaiDuCceWPkQAlJ+jqj?=
 =?us-ascii?Q?FndI5rkBTjDjUQNtT0xX3suWZGyoHueSWrgnRZeg90KFJ7k4l87/YrCNPLTH?=
 =?us-ascii?Q?hjJqUfrShiwKo+T1/ak7Byp/lJCbTqhOjHrBlYI3Nt/CVtPbrxK6ch3lF5RN?=
 =?us-ascii?Q?MxZKWb3fytVLJpiLNmlR3uip9myJSQ0iZOMBxScebE7uVRtrMzbon4uaIfHf?=
 =?us-ascii?Q?gumoo/ps/LdbMLQpPHwVOvMMvapTREN8x4+I8xpL/yOC3OrMXCdL8nC3Nz/h?=
 =?us-ascii?Q?w9WdUFY0z/irSuTVeY92H6y7OEVx7us+6n1prajSPnzkpIBKu9GCKXqETnUm?=
 =?us-ascii?Q?IRbujidlFif6H0vJGSlCovg1LOq7iCk+mjFUcbDlANEX83XiP369Mk7h+KZA?=
 =?us-ascii?Q?wX4aI9Tcx8gyUEil9xqvlggMJqPOVQD4/O96Fsk9rA6w/z/n6czhdTQoKkYI?=
 =?us-ascii?Q?+I0GrFap6evuBtBaX32I833IYDwponN+t92PiC8cWOOk/x+fxBVFNa8f15yZ?=
 =?us-ascii?Q?e35H6MAsvVRwTcFAW1G8NLf175nv1PyqZ0z2PzUZe7zf+l7OQ8JCq1qjgfbK?=
 =?us-ascii?Q?t6RRBluUVeCV+HIHnrjYu/y6IK/R4Hrsh6rC20YkdOCq/lZB5QnA+thbbiKI?=
 =?us-ascii?Q?+Dd2DgoPL3lD+4iaOsX2SuCmBzuqLswVs+ZJQj6aN3ZI2oAS5bzQd9gITRgS?=
 =?us-ascii?Q?9Bz9yjc1S0RSRUzpxyG2nQ4VaC5MfjPR6XXaycfNl5KfJ5CDeP6p2GW2Npoy?=
 =?us-ascii?Q?8VUYMm04Ej4coO1v+poNOrsXhZE8mrIkUSEQNxrEo9e3zYPtYW3rP/unj9DX?=
 =?us-ascii?Q?RCAHWN1Iv/Pnlxdx6VJsRin9kt3vBfGfQIihd1pa4S+bqAcJDbTeM+YyRQz7?=
 =?us-ascii?Q?8Zc0c5U7kOGH5oTwsi7Whl/2UeYSANo7sPE0P8jXVadMFeGeRLhxMMzk6R3s?=
 =?us-ascii?Q?8YYiJCOKLfmrtiqGUzHQ6fD0QNxl8XAF1lPTdiArIa9sOmacXzSOwBWw7Lin?=
 =?us-ascii?Q?RAeEVQzNLKeievAa3v2SdXX0ZSHdfnQMD5UOlBcauc27pjUGXw/Sb6NB2F6A?=
 =?us-ascii?Q?0Ncl6UjfOtLA5wrG8WQaeyMsudwdXUoUc3dTWI/KtlOlZw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657c350b-f606-4bae-fd1f-08d8fa9dc8c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 14:51:26.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMF05oDGA9krdH7U006AR5wK6Q0kVKWImrcdOad7h6p+tTisvgAu39Z9nHSbk81h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 04:44:02PM +0200, Gioh Kim wrote:

> I think it might be a solution to change the
> rtrs_clt_remove_path_from_sysfs as below.  It changes the order:
> first remove the session from list and then destroy sess->stat
> memory.

Freeing memory used under a RCU lock before doing a RCU
synchronization is an error, so at least this could make sense to me

Jason
