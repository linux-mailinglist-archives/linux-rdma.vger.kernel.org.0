Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02E34FFD7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhCaMA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 08:00:57 -0400
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:14280
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235035AbhCaMAo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 08:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMa9bLiC1WJ6A5EBDGFjlsZ55nziJazfJsVdVuh5RQ34UbZr79U3IMVrus6IQNjq3Dfvu/bLKY93S3tyvibKjx54SgQr1ORVPd4F9eTXBrOGeDMIORuShwiFU8misQ9UgaO50HcatG6Vevl8/95N0P5EHGaQg2Kohs7nLmne/+NG2oLIfJRPG9RjcmgyVoqbxffpZ6f1Bf0muqj3Cd6U3zqNQYn67Cs9V4dj0mkmhnOTZJUX/H/B/aiLvj8AQt4C11cvcij1YbfY/MHgc7Yqm22GoIHRCAk3dQ66FYGGuch1lNmPgvaY8/xUXs/PIdjTy+z0gbk9KpMmb0Kjr1mIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y92xF57lq2F+skVNOaEjKvoP/h7VDghoA3R8U+oHLmo=;
 b=acpzr/0oSZTkQtMKMpCOfgFr5GdeIzMd+eDR3B0FigbsTrDdjVGXY9T+ybz4pfzpJGCJNBRZPzkDdMptTC4AOs5lG1FOHvczyPTpUBvl7BHlMx0+glL/rix6176r3hIqlogp11hsezbdrAogWVdrrL+Rm132x5tTzJ/Xqzm2EXBqE+D/Vtq2A8yg8hcvtZyP/SyyAfFBbK8wffNGqag7S4u7tFLS2JQt0yv5+Z6xJQw+NFgYqaQR8u4lN1t3OPp2cno17+MjYOLG4mdRflipkYPa4C3u8W+28gxNjDUc+SeyiI8SV+loiMRpWfAQdMgPNNBSEINx11Qr01SBl9Zrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y92xF57lq2F+skVNOaEjKvoP/h7VDghoA3R8U+oHLmo=;
 b=cZ7V7AjInkpesLmxT3xWDQK2T6kAvWHB+kfUwIKxWiFEksi3OqXsgp5TBtw0QVZXO4GhheL8gXExTWl+R/Z0nalIf1qFn4Ui/Jpbvuk4TMp9/Ets4diPvCTj17cIJUWMcNNBzGJovGXOLZIg1era/oZTRs453pr+Su9ONiitX4yBxCU33dBmagz2OROHMAfUs126E6GWE/SCL90wQX2fsipW1sUKufy05fzcllMQu2QnPxzpxx0EY08+vYhxPqAW1+9gu6MKwBQVOGYC1K6mG7TK8OH3f+dOQIdc0jNq/NCBesjFMdQ9I796/+T9X7LaAXkDuX2bKkvaBq8jhSDHLA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Wed, 31 Mar
 2021 12:00:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 12:00:42 +0000
Date:   Wed, 31 Mar 2021 09:00:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210331120041.GB1463678@nvidia.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:207:3d::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:207:3d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 12:00:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRZWb-006JS7-1e; Wed, 31 Mar 2021 09:00:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4d25e92-2064-4be5-cc92-08d8f43c9bfc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241765AAC823CA2C81E0B74C27C9@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47ewBYmSTA0dlQT/31Nb2WjzYinZkhzlb+6EBKyIbx6EJorF01tiYMd2jWECA+2mKJpDHnS+xIdj4QeS7Vhb8WjvLxSvCOP62F4It3Rs1yIK5pPXg7RffH8GCB/MMW0IR9qQU00uK+X1oMtO12MWLtwPp2HM9yX48rmoiHGEDuM52aERAl6VMqp69ctKioFxa9A+yaudfoV9TkEjdJz+eWHoaQxQrStlui7XeStrMslaIWqIIP+PVRMCXufdwWJrWqGs/TVGY3eFCtFoaaWZOaociMbMZwaEF0ZbEZnbyXkJ3mfhz07rI6Cjo9456vnInPP8yYvI1dWXFCVdYkRqmZI10wISQTHpbJEj2DYrngUZYxpi7Bbgbcgc+TI+WSQqByY5osbP+U/Y0dQgc1ni4srmWdOiIHTPU5CLe2Kyyy9aBjca7YzLFpMuF3hpKJoxHIvS8TslqpZiZxvMz/QHDmwQ11b+HzeaWCJ8Uh9u7b1jWLJQlQvmDTH0LrD4kw3R0oUdj/6XpjMIcviLtqPl9kgTzZ9w6I1eYWqEjSWJ9s+zLKpNOQhf1ykdYcGAIp9q7+g4ljSTfVe534pGXzrT4K4SOuRXgAnM0o0inABxrvru86UW0nZ7ZFcXPJn1woDeBV4ZR8reRI1bt9MvWXogIswevCD4TvFETCcTIqQQbjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(2906002)(186003)(66556008)(66476007)(426003)(53546011)(36756003)(66946007)(478600001)(33656002)(54906003)(26005)(5660300002)(6916009)(9786002)(316002)(8676002)(86362001)(8936002)(1076003)(38100700001)(9746002)(4744005)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGE3dzFGR3c0Z3FhVFpIa1JLZDdVQllobHhEemtTdnA0dVo2YkxINmQ5ems2?=
 =?utf-8?B?VjAwUGpSWHFzYVlCNklIVVRlRTBMT1FVNmlVck1GQVgyM0lISHdDcC8yWHNP?=
 =?utf-8?B?aWVuVFFmUVZCNW9TOGNSMzRkVW9iNUcvTDVvaHZHNTJZMEhobC8xZ1Fib0k1?=
 =?utf-8?B?VG5vcWREc2ZoS291S0tkWUtzQ3hWaStzdGloOFZqR3p5dUY4b21xODFqUWNN?=
 =?utf-8?B?OXhNb1JFRGxyRlZGWXB1Nmw3aXZ3WmRsTUdzdXhpU0pPUjMwKy9oUmYvOStT?=
 =?utf-8?B?MnBsclNiVWc0OE5YcnlkdTlJOVMvamswOXdoaHo3bzVJNFV2WHMyN0htZ2Uw?=
 =?utf-8?B?YjlCZllBU0diUzJWNUdOcHpXRkFmZWhpNDR4c0c0azJzbit1ZEZ4R1dqczFr?=
 =?utf-8?B?WG1ySzlrWWQ2aS9IOEtsQTZYMHU3TU9xTjY4UVQ1RXl4WU5MOWhrTkRFRnNQ?=
 =?utf-8?B?eUJQcUhHUDZvTjNpRVZoM083UW5aMks0NXdBRmljMEw5WXdaWVA0blNXMmdu?=
 =?utf-8?B?b1RGUjcvVjkwTWFwL1FuZzE4WisyWkxhWkU4QlhtaVkvTGVvUVBzSU1VNlF2?=
 =?utf-8?B?Z21YbHF3YWFXZ0xuZmhRTGZFbGNpK010ZEkrUEY2N0t2eWhCcHNYU05ZV0p6?=
 =?utf-8?B?dEFMTlcwSFNPMHJINlBlclRqTlFsN0tZdHhSZTRBSFRGZjJyKzIyVVhrNXRT?=
 =?utf-8?B?MWRlNmJ0dUJOUHFuQlZ4bnlwL2pZM2pGK2Q1aEpCWlp5VHZJbVN3WkFqclBy?=
 =?utf-8?B?Wm12UWhwSGwxKzNCWGM1TitPSWdkd3lseVpZOG9rVW9lQ0IwS3hkWFpVNG9Z?=
 =?utf-8?B?VWFLeHhHeFNnUXcrbXFyWVRxN0pOTUZ6RUsvYkQycDBVYVdzSE1VMXRDdk1R?=
 =?utf-8?B?NlRTWmp6c3V4YklVbEliMjlpaXM4RlRXazN3TzBadml5R0ZORThPc2l0NkJj?=
 =?utf-8?B?Vm1Pbzdob1NtUDJ2S1JUWTJpVTJ2a3k2d0lXbDBmL2xwMTNOK1FUS09sUGJn?=
 =?utf-8?B?WlRXd2FQdzQwZUZaL3djcS9Db0VJcW5ZWDB4RzBWSlhUSFNHM1ZVSkhmQlRi?=
 =?utf-8?B?d2hFanFwUFlCZTZPeWxRMk5BMTBMTVRZWXJqSGUrckovWkpwYnUwL1lnaTlM?=
 =?utf-8?B?bVZFMUdTa0FoWDR4bjlGc0NpSVRCRkpDS2NSbU10cWlUazBFQnNPWjFtMWhB?=
 =?utf-8?B?WjFCU3U4WEYvbzRiWlpDK3k5Q1I2QWY5NHJBMUhDTE5ObDlHZ283WWFxY3Rw?=
 =?utf-8?B?RUNEaFVqY0kzMkRNVUtHazRpMXQvQy8rVTc2eWE3dm9ZN0JEYlVxMkNhZzd5?=
 =?utf-8?B?QjJQWmVsUU4yQ3BIbFhLcGVuYmV0ekR5cVVFekZRcTV4VmJIZzMvaUYwN2t6?=
 =?utf-8?B?enhIcjR1TE1GOEtRM2R4cnIxa0pGVHJsNFBDR3hRamQxelJXTTZPRTdwSm1J?=
 =?utf-8?B?L0pWMFV2MkxTZmYrVUs4OEkxNFZiSlRYRkpsTGZDTWZIcGxjdExieldVQThR?=
 =?utf-8?B?K1N5V3ZBSVRFbitVckpIVWNDUkZGbFNieXBmS1l0S21jZEdPYnpWdzFnSUhD?=
 =?utf-8?B?aWZqY2R6WGNDNkt5MVpZemsyRGF0RzgwWWtEWnpCczRaRmdtR2p0S0xoRVZm?=
 =?utf-8?B?VlRwa0FxR1g2UFZ5aWVRQWRqc2wzamdwdzVMWUI1RDFtMS9XRVd5UExQYnUz?=
 =?utf-8?B?VlJ3TDhJeHpnbmFYLzFlZ0FzOEVNY0JNSU9qSHppR2xoNTdNYnhGdGFmMVF0?=
 =?utf-8?B?M3hkWUhtMEI3bmoxOEJvd3dZMVMwaUpJNXI5OTBuamF3UDVVVXllY1dsNHFR?=
 =?utf-8?B?MmJHN3dybTlXd0lSb2o5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d25e92-2064-4be5-cc92-08d8f43c9bfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 12:00:42.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nwMLAsSqkx3Do4llDWwbEZuRLaM+TYZx8MC6owbSm7e9hf9lQHiFFVDNV0brd+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 10:38:02AM +0000, Haakon Bugge wrote:
> 
> 
> > On 31 Mar 2021, at 01:12, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Thu, Mar 25, 2021 at 02:05:47PM +0100, Håkon Bugge wrote:
> >> Introduce the ability for both user-space and kernel ULPs to adjust
> >> the minimum RNR Retry timer. The INIT -> RTR transition executed by
> >> RDMA CM will be used for this adjustment. This avoids an additional
> >> ib_modify_qp() call.
> > 
> > Can't userspace override the ibv_modify_qp() call the librdmacm wants
> > to make to do this?
> 
> Not sure I understand. The point is, that user-land which intends to
> set said timer, can do so without an additional ibv_modify_qp()
> call. May be I should have added:

IIRC in userspace the application has the option to call
ibv_modify_qp() so it can just change it before it makes the call?

> Shamelessly-inspired-by: 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack tos_set")

Hmm..

Jason
