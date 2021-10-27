Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A68F43C902
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 13:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhJ0MAE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 08:00:04 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:14049
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231717AbhJ0MAD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 08:00:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls3L8PLt4QwAXwg/oS9dHpSR21PNvFHSdUi5NhdR7mZdHO3Ic+ugmYesV9C95IF/YDKnchfsNG4BiVa1u1mZKyLu7gnPlXd6UjLRvMC8TZZmD9zlIvq55ChgqBR09XQoJ1mioavSVwJFWRpM/fjCc+JfzLRkfzTysmpnak6WKqL+HxkqjIFtXNMI3G/7PKrDMSCnbij4z3UbLi3K+vk5CwjTfbwiP4wu7vUY9jPJS7rS/BwxaWJ/HThUjIythNCpuhVcM8XEikVetWksOosZ/Ng+UejFA6Y0pKT7gxQzs15boTHqSwQu4JPhzYXIKVwgwNXG3VWONkibaauj6mHSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh3KYZPk0fyW4EsW4IzAnZpbFkOrx/sTi7F9OS0llxw=;
 b=Tp016S3KnN8sZQ/EHn8xcnG4/JVahpLSh0P9Y0BC3uMXoeTEuIS3ufq/0cvLhODNfDbXQCru73eu8D9OaIha2nsgDMqflVlktDcTaazeo5avxGrxJiPQYIAOexXYdtHQfUVb3kXJagA7cH/i4vuZixcgb2DNz/von0RnfjROS2XPey8W1GIzUVbBJTxURVeAXu+cFy3QYIsv9cRJjEXJ70pstk1S1xMsOZL/4+h71DXzLDM0wnEy6bQOV8VGna/zmphHmCwvg2prFzjehAFEC2BX5vqf9hzBF/DwG7A1g1mams55T05dPvtcMa8dE4Q0mnWYlQ/08BEezcXpePrfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh3KYZPk0fyW4EsW4IzAnZpbFkOrx/sTi7F9OS0llxw=;
 b=RauwsEf9VEx7Dp8mIXD6qr+HMoI6+eirXSJBSJLH8U8DkkuBN9HjpuaCKKv0Cu2XevmBoebCuoxCoEzDAbWZZZBZUve47VV/8K4Fu4DN2lmw4jHzuOO9Q75i8t9w5CW6pDps4MmZxFBk2avxrh50jG3iUwhB7tduMtCfTQPErWp0etC592yX71vr6rT3JicrA4l/s7JXZAx7RfDGQFtwSdDDcTUxn0liLn8RDioArddrMLslcR53u+9sQCeEmrF0wq2iL697rlMyPqaJcCaRbwPdPUzP0Yzs78XmFISYoCs93RUKTFKNWpfypcfACcNPo8TsQu7/w4OUxB/5xcwwKQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 11:57:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 11:57:36 +0000
Date:   Wed, 27 Oct 2021 08:57:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: attach multicast verb
Message-ID: <20211027115735.GD2744544@nvidia.com>
References: <f5703260-46ab-2d96-e2db-70e9801741e2@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5703260-46ab-2d96-e2db-70e9801741e2@gmail.com>
X-ClientProxiedBy: CH2PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:610:54::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:610:54::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Wed, 27 Oct 2021 11:57:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mfhYl-002LQd-DF; Wed, 27 Oct 2021 08:57:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00a2f487-03f1-4c25-db2f-08d99940f7e1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206804CCC0A5508809F5CCFC2859@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LndAjSY6o7ew1w9Fc2ZNS+wOU7OvKjKjwlCS6592nd/K+ZPpVGFayEQ2+wsX5//8WpHUi3ug+KstiWcc5OtCxbroI7l7L6g0DMxyLQ5wauCRxCmjMIi2cMIPT2EZXS5FVS+vYyNqKt05cimn2HQO7TQXyq3nCAhhFiCAs8vMsvFAgYGFvF/5YYe436FYLuob+xAQ8O40pa+cLxexG45RRKCmUhjgr/2nRFsoorbZHlrMlM/O7HTWgWVELY/2y9qxfB6LQQAZPnmWgfI8WGWhIMBGr9Huu6rO52dwKVb/jDwCEnsmWZiCNiDJg533fo3rAZwpZwH+pTxkRP8kxXwV3WxfKxzayu19hRa9Mu79cfbbk+3O6lbu6LF4vpej1sd1r55ZjYsmPWlF9ItrPXmr1HcwCg2BmvedowwFo/tfcnnC3IGk3wKiP4VKG96s6OhHAS9wmZpadJGahG6coAJQ1dUfkshGUVt/dPTv5wtUMZ1o3VNR4wH0Zozi2j9hIFZ+AOGbJoL3m0T7Ia5LemexmV2lSm4WRgwLFAehTRQVtL+G8RRWrNysEtP8V9yATcVMqhyY4HTDFKOvEtbpm/c8L9wWxECS9ob4EOgircLljnclegAgG8Dcvw+q5/i4PRnHp3AMZ2/PH2cXencvU586rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(9786002)(9746002)(2616005)(86362001)(426003)(4326008)(2906002)(5660300002)(66946007)(66556008)(66476007)(8936002)(3480700007)(26005)(7116003)(186003)(33656002)(1076003)(8676002)(316002)(6916009)(36756003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8rnyM1OooB8U5KGA/WQMQX9JScfhSA2A6Pj0wHlVKZTC//AZzA5SOCcu3rv?=
 =?us-ascii?Q?GDsIjvgBAAdWcESnfEQ51YOpIdYuf+KItMfWbS9540nxAonqEhgN3Qg6EYR9?=
 =?us-ascii?Q?NVQ+g9BWEmmrpW5oQUHLjmHkXnTb39Mk6LoeKTw03rf7P/0iduSpTqmGdWT8?=
 =?us-ascii?Q?55UW23fdXVx68HUF7EQozA3kp+mlWvKR90288eS0/7Xfpi9YE+pzbQ/3dYpB?=
 =?us-ascii?Q?m4iNooDPaDWeLCYj3suyWCN/V6HExhfupedp45kxsTUFeZbLzVXrkO4M8Hus?=
 =?us-ascii?Q?3+bNfJ3v1jR1KHGI9ER5T9+Mh3/g9pfOTQNLhbdSw/Wb9JfJ6TSWhW7uzp2G?=
 =?us-ascii?Q?9ecTpUcLeUMWYZ0SBPFybmq/hBdacnezqJyzddGSVLpHq7xOaKGHvqCzuiBj?=
 =?us-ascii?Q?WuxbBkMQz77c6fhbN8k7NnwD8fmK9qLxyZvrt+WYFwZm7W1Bvr59xDF9s/si?=
 =?us-ascii?Q?rM+xXXDU1XdT+BBPp4eS+jY2mx78cgtjCUQ5pyqyq4BDwE3i3LuJszLA8cRm?=
 =?us-ascii?Q?/cO2NiQJJKUOD5Bg4ttSidddXDrLfqR56CrLDFfu23ta8m8FqtS2b3FS3bJ/?=
 =?us-ascii?Q?krunapEtRdugbCPMU4wxj13qy9f+YH2rHHz/m5Egr7b0YvJB2wmERmWbfNbB?=
 =?us-ascii?Q?m6cpp0HM/gpDKOGOkjGb+hCF4UYEwahtWGuw4jmorGfsqkiuY9UBbvhoisEx?=
 =?us-ascii?Q?D4dlvVGnvx2Urks7DlWrZrcX4QXt79Y7krhwHRr6Uawr+nNAVLbwIS1BrKSa?=
 =?us-ascii?Q?7vppwkp1o4le4DN2NjbsMhKe6+Dt+1r0M1Jp1SkwMPJPVAmHn7TAvCRzwZ6m?=
 =?us-ascii?Q?KOn0q0nIE3Dsyxq0P+yFgYanbfEDymZ0B50uiPRBFag4Ec3MqMyzRHVkkYCs?=
 =?us-ascii?Q?EKgtGzGg5tTphOGa66spds8wIUG9b1TmqDThuEjGKCGufwlN6YksJKLvg1VG?=
 =?us-ascii?Q?JCbK5lggSUJNkiYs5cdyjMevLxG6VzbKEF9jMW4BtQmcwsa0ASdvFKnZuq8e?=
 =?us-ascii?Q?bTkoqYo9keytY283dOplVFIqs0OgYdJ1WZA3Qqrf7JVg9UDYqyNK97c3omaa?=
 =?us-ascii?Q?RdAZhBvGjo3DvEgpMHKEOQI+CAe73JmarT0pBHDq7n0ctdi6waaoEJkOfPFO?=
 =?us-ascii?Q?ZmyCp4Y2l85b3blm175T2YzICoxkXB4gG9G2A+N07g4WIEH4UXfdHJaKJnaV?=
 =?us-ascii?Q?1K35zz2L7lAJW0jHl79cTow4ZZ/Pci7th1FpZnaQEEGX1ez/zGBWDcajEHuk?=
 =?us-ascii?Q?vYGPA5OVpQd29vRFZLu4WwGv4waZhS/jq0e14P8kJMhDyoXIyxvW9gRAgDQi?=
 =?us-ascii?Q?fsexMbl9bi/kakwoAYjNcvtq4wimJH2oIwU0Bz/8Zw2fGoYbuWURIrS6S9Ql?=
 =?us-ascii?Q?aP6jiKXMotU2nZKag2XUhWjgmzAep1qw4vYO8EQRc1rEykfEpDmL8fesoGGm?=
 =?us-ascii?Q?TRk9Foo/x3M8XdY42rLyMGnO0WzZQ8eEuPiWNEjPvMEnsn2pUmqsiJd6DMvh?=
 =?us-ascii?Q?wkt7wsp/AwzKBpx2lvz9kQ6iTWas/i7b2GHpIG2wBNJzdHtoY2PfOtc2O/Ef?=
 =?us-ascii?Q?hZpBcqH2wzLLUj8W5+8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a2f487-03f1-4c25-db2f-08d99940f7e1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 11:57:36.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReHEftYAt9cieEuASHLNxLjgEPKP7jK0N0Iq9JomqAqkqZl/hxi8P6PYu+nFa2Op
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 26, 2021 at 12:03:49AM -0500, Bob Pearson wrote:
> I spent some time looking at the current code for attach multicast and it seems likely not to work. Unfortunately there isn't very much test code for multicast over RoCEv2. Currently the rxe receive code maps all ipv4 multicast addresses ([224-239].x.x.x) to IPV6 unicast addresses using the 46 mapping 0::0000:ffff:aabb:ccdd where the IPV4 address is aa.bb.cc.dd.
> This is then mapped to a 48 bit MAC address using the IPV6 to MAC mapping
> 
> IPV6 mcast addr = FFts:xxxx:xxxx:xxxx::xxxx:xxxx:aabb:ccdd -> 33, 33, aa, bb, cc, dd.
> The 33, 33 identifies the mac address as a mapped IPV6 address. The real mapping from
> IPV4 address to MAC address is
> 
> Ea.bb.cc.dd -> 01, 00, 5E, bb, cc, dd with the msb of the bb set to zero. The 01, 00, 5E
> identifies the address as a mapped IPV4 address. The mapped MAC addresses create a filter
> to allow the (non unique sets of) multicast addresses to be accepted by the NIC.
> 
> Real IPV4 multicast traffic is not likely to be accepted by this.
> 
> Is there any documentation on how mcast is supposed to work for RoCEv2? Or an expert
> I can direct questions to?

Can't say I know which is right either

I'd rather expect someone creating a rocev2 IPv4 multicast group to
stay in ipv4 land though

The transform to IPV6 multicast is something that rocev1 only should
do.

Jason
