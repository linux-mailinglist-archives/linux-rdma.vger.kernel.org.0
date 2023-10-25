Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19507D6545
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJYIg5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJYIg4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 04:36:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D282B0;
        Wed, 25 Oct 2023 01:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJrvzC0c3oxUN8sce3tbqlvoo0BrY8GeNmb+CugVKXn87sCxECEI8UvgylbiLBVh/TF3oyR+KdJRe1e0aNpkQCQ1NWw4a/pMQYGrLvd88n3FE6AF3q7/8m7mfY2LUSAKbf/TbQjUYxDEx6TPwP5suUToi99K8q2DSGuphTMvuqO+Pi9DGv8fyPn3NKDN0713MC5rGO6KZipp4GFWRrGCsq+SubTZ63GYs6WnkP+3t+YFzrBX9LngeWO5GTzb+zqIswaP8iXySfPMPDcsbTtOIQLbqTWqfYlkcJRd4ogbv9Jvb0moD3WBYIxeLD7PW67dlisPP2Bt1gbFCURiafztkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxayPP/luNLaKjvgF065QQKKQkewhFy24DSRUjQOsWg=;
 b=EofLLCyhbIRans4Yu7EfDjPGgwo3ofik5nlAadXXiF0yC5wyCB+5Ym6IstIoYcRhxePj4NdVSBQqiitNAL9uTo1F0wTfBElfHO7FMoNpDOY3GTA61niMavsz2UJ7NCBqHVQNbXZuFd1YYcI5VmoNi2P4527diOlw1TmQaIhSk1F8GVCktQhvzLu6dXYd/OOwuaxl5kpsM0rvCRJ4Z7J5ZAq4NoNUqpx0HprYMWyaaGZ8lSkzN5q2meRUQ/tX1LKmPxwPPpiIKKYXOjVMSogkBSWI1suH7MMYGQzoV1umkZrZWYCCJKtqXS1a93VIN83e5NnAUwLfiRGprOVCWq7Tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxayPP/luNLaKjvgF065QQKKQkewhFy24DSRUjQOsWg=;
 b=juDBx38lH7515iVRpVFRUJq4E4ExVtVE11NeRLa+A4xmq/45KXctlZqb2/5xDNGW6zkfSIh5sPg7EtkGbs/O2b3FfP6MKkTyle1/c3bm5riTFE3J4kUsgxLAGhZchcNeSFVho2JUdaHbFEyqKfEW2CR6vzLau5fI7W4Q+dWveiT5mzS7yPtyF2TDQQ769AWYPCkcU+6Nf8fYK3wnmHFbS14IQQOfFFpvlQstRftZ3lpm8QROjm9Hx9PvF0MJYI8yi7ijWGf+2rZhjVtrzE+kdcGiVRdseWmkUiRD+q6IZzmqDFPEee/otZP6sMHezyxt1iRAs+2dDNL0DZgNfdFWPw==
Received: from MN2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:d4::16)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 08:36:52 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::ab) by MN2PR04CA0003.outlook.office365.com
 (2603:10b6:208:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 08:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 08:36:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 01:36:31 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 01:36:28 -0700
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-3-phaddad@nvidia.com>
 <6a1632a4-28fd-4fdd-b9ff-34dd2f0bba88@gmail.com>
 <d97b7d9c-e5e4-8352-d805-e7ebcbad80e3@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From:   Petr Machata <petrm@nvidia.com>
To:     Patrisious Haddad <phaddad@nvidia.com>
CC:     David Ahern <dsahern@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: Re: [PATCH v2 iproute2-next 2/3] rdma: Add an option to set
 privileged QKEY parameter
Date:   Wed, 25 Oct 2023 10:34:50 +0200
In-Reply-To: <d97b7d9c-e5e4-8352-d805-e7ebcbad80e3@nvidia.com>
Message-ID: <87r0lj5cad.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdd2d03-6d3f-487e-613d-08dbd535893a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5zmC5yn1/H8erIqPC0HTyx7j/oqGJukrUwYVW3a8VEL/XZJvlnuSnLdTQhxGf8D0ugCJ5gwHSnFVqjYb5ic7Irugoj7QME07yuX0Wdm/kLMs2I6RtGncaoyN8JA3h8VmZs8z/G9gsOuXmKPjL0PD4Y2URemBaPg5WuGbtaB910Om2YQVtyiU29ZmhWDdHJWkYKGw4vQhXkPz1915A9XutlA89TQ0gVySJgopSGucLCIsGYo58uA/6vD8kJYlV4nEOpK2t7XMdsoEWYh8rxLa68uyd0wTgZPRhAzDlnr3gFeLxoy+I2Qn1wGnmwKZflHc4tJw/9QfqEDa7q8yOWOaQ15+uw0/rPZP1KwY3AzzhUpX0p2Rj0kWBD58YBQDxI9cbYLUf1awh7DewnUfgPU3ZUAjRiUZITXhNuHuOxM6iH7wiqVyimAsb2fL0qoPd95S+ryHPVDk9s0ciA+s/EXYYvXT0i9HP3bgCr/h89dAQrJlnySPg0L7E1Qq+LpV5AE5IZmHkCnuQMJXpy3zaWxSCuqTI+YPlWvrPs1x8hjrkfnxJma5gF0CASaBj1Xucr7i5/tosiTFHhy2s5CU7QEONmRcjmah1ayIjAuh1tIy0gBqZ2eabaSXCVDXVZH6AVB0K4NF+b31dwry9NQv6+YzwTcZ9KiBcQVEcy9l0wm/xS2cQVeUb1r0ooFjQW6NlqPxaDMzgRQGB9jh+7+Y3vyO1g0S6bEjgBv2IN/6FRgrUx0kPl6I64jV3yYwFpBMcQz
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(26005)(336012)(6666004)(478600001)(8676002)(16526019)(2616005)(53546011)(426003)(47076005)(41300700001)(6862004)(5660300002)(4744005)(2906002)(8936002)(4326008)(36860700001)(54906003)(70206006)(70586007)(316002)(6636002)(37006003)(82740400003)(107886003)(86362001)(7636003)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:36:51.3469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdd2d03-6d3f-487e-613d-08dbd535893a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Patrisious Haddad <phaddad@nvidia.com> writes:

> On 10/24/2023 8:02 PM, David Ahern wrote:
>
>>> +
>>> +             print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
>>> +                                "privileged-qkey %s ", pqkey_mode);
>>> +
>>> +     }
>>> +
>>>        if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>>>                cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>>>
>> keep Petr's reviewed-by tag on the respin.
>
> will do, just making sure I understand "the respin" , you mean when I
> re-send it ?

Yes, to send a new version with fixes.
