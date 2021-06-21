Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84F3AE8B8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFUMH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 08:07:28 -0400
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:6753
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229719AbhFUMHZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 08:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXno9nNlO8XJPvL0MzxQC+FANiJReCFa5FX7uyg1A7KBvHKpr8kbZuNETdedfFacg93hBzPgMfij5cE/4iloLNJFL+Vs9TGgTJ8nkOVrdHrO0F09eDtrPMyLaFJ4mALeWkrL5uFUEFxHC6z4yzGG7NnT9VXaPm+AkjIuh6fN02VkoZm88KW9DcmCwV6qYKECbkmZo8tRuHGM0UMVj8EXo6iexAs/2IP5k1TvcF+gFtf+PjXk/MB0061dR+mDJT7mbRehgjBY1Vnx1wOmP3aZ+h1L2t9PtfTQXV8wzcZmsscsw2O8px09lMwGMyckyd2pMX8IqP2Oytk/5aQPPytbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHXtTjVgnWCofh5fbSleYrXAdZTEesDatrMl4R10EQc=;
 b=VWQOKbkkh9vkwKzWnimlh11gp13zY7f1fz46dGn24JvLnYIoZflOEI0QCBf7Tal4SIgpuHphRVRTLZbWqgL/dKmcyZOEm4g/d7QCReUcOlxWdNAE34vu21NfzNFL8VIh4gg9cHhwyZYuZ7Yzl8g4suUaCLBEi0lfsnysqvRKLxngQBa8NoGLyqG6jweQp6UUY/3um1wTAhaHhXjTHTI8awPrgQPgpmCRWNQvSiNYP+Kzj7uIAcEIC8Dc4JDUEKtqq3NG46xN8BYXCZnX4DaiuYdNJ0YDMUanZJmS66+2vEO4nVagrLZMZaqyp5WC4sWkOg/gZLGSHTSMWRULJNXVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHXtTjVgnWCofh5fbSleYrXAdZTEesDatrMl4R10EQc=;
 b=bh13kJWUba1PGuFHXGWOHb2QV3Rrtkn1IYLYoCYBjC8YH8jaQkQs94LRgFeKLV9IQkyo563wwh+igScNH8Dvtn5PoX010gKf1OAIeId+8Exf4I9hSfjoojMR9tl8jntZMBIk62qASHJzXl2Tay33saBD+nr8uXfAA69LzCrTrJar2eJcnGYu6ez5Ah6qd+J/eNhyHJWtxwRrj47/7N2mY49/BZ4yjknl0UVwnzyenJBO8CHc5KP0It1XPQpN+bRMx7W8XtKUaXDRdliENlTKsnXTtJSJofqHklTdJjrXjEN0IAgUrmqP0YYoK8x2teXwrjo2v/SDMeRcpOq98rSSag==
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 12:05:10 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::a0) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 12:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 12:05:09 +0000
Received: from [172.27.8.67] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 12:05:07 +0000
Subject: Re: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT
 transition
To:     Haakon Bugge <haakon.bugge@oracle.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
 <6e6e93a7-f59e-8c67-c5d1-e6a64a556a54@nvidia.com>
 <BA591410-6EF9-499C-B383-12A0A550D46E@oracle.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <110980ae-cd27-4c3a-5e88-202f7e425832@nvidia.com>
Date:   Mon, 21 Jun 2021 20:05:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BA591410-6EF9-499C-B383-12A0A550D46E@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c5677f9-4e96-4de3-ecc6-08d934acd158
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52530E892F2C341D9DED7C50C70A9@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VZpYpdP3C+P6gXOjQGxTKgC445kEdkI2RVtmElnqS9h01rDrTi1hykbPIw0vKd47vKUamVVoNnp595KVwFSVQ3dqF910h0/zMKfGXL6UUjZVAdM4/XyjMNPxKuToN5jhGRS55GyUr11phb+Pffm8cfWxqDTknIixsNdH95UPR/VryFRRUGJkCS7pTprcrGDbsuqKM3mDGoCCtFUPcDEy7STkmZVBcMz0e1wgpQHSzC3vo/9Bn8ygxfiZ7/RAHH4hAjQnbo4TI7R/iUIW6a/ADPCmEy65+iRadMhY7IfYB0DNFhMfQ3A4D6j2gSODcVAoBB1QAp4350Htb3zwtKO1xXKj/cZ4YnOV72MVQ4rakbevULmJC1D/wN5AFHQIwtedwArDl3mNVUaIkenW90R6+nmVlaNm7BfusPP4w5xjRnj7b9ONf9MGcpJKRVm91clzp34I9AM/E6zBhyt9tfilckFvEEi+bYzP14BVb18BhSDdYZ94V6T+dM6BOpKIYA5eirugUODgiY16aI+T5qmzF1f2ITarl+pU1VabxQP8GAfCN+4JgsEOYGf0nH/vmbW8lD33mWSomh/2cC/yZvKPbD4oGoJUcAA2ZnhDCNE6picO4JBa38J8kwWG5GnaGLValALGG2LeFEgo8mhTXGYfSW8O6mGJSQ7ZBH3l+6NXC2sE6E+KV1I/no6o+bK3wQU
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(2616005)(31686004)(8936002)(82310400003)(70586007)(2906002)(4326008)(6916009)(53546011)(36860700001)(336012)(7636003)(5660300002)(86362001)(426003)(66574015)(478600001)(31696002)(316002)(82740400003)(47076005)(36756003)(36906005)(54906003)(8676002)(356005)(70206006)(26005)(16526019)(16576012)(186003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 12:05:09.9002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5677f9-4e96-4de3-ecc6-08d934acd158
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/21/2021 4:44 PM, Haakon Bugge wrote:
> External email: Use caution opening links or attachments
> 
> 
>> On 20 Jun 2021, at 14:19, Mark Zhang <markzhang@nvidia.com> wrote:
>>
>> On 6/17/2021 11:46 PM, Håkon Bugge wrote:
>>> External email: Use caution opening links or attachments
>>> In rdma_create_qp(), a connected QP will be transitioned to the INIT
>>> state.
>>> Afterwards, the QP will be transitioned to the RTR state by the
>>> cma_modify_qp_rtr() function. But this function starts by performing
>>> an ib_modify_qp() to the INIT state again, before another
>>> ib_modify_qp() is performed to transition the QP to the RTR state.
>>> Hence, there is no need to transition the QP to the INIT state in
>>> rdma_create_qp().
>>
>> The comment in cma_modify_qp_rtr() says:
>>     /* Need to update QP attributes from default values. */
>>
>> So maybe both are needed? E.g., qp_attr->qp_access_flags maybe updated in cm_init_qp_init_attr()?
> 
> I'll give you two reasons why that is not the case :-)
> 
> 1. In cm_init_qp_init_attr(), which sets the mask both places, the mask is set hard to
> 
>          IB_QP_STATE | IB_QP_ACCESS_FLAGS | IB_QP_PKEY_INDEX | IB_QP_PORT
> 
> If we do the old RESET -> INIT -> INIT, it is the last modify_qp to INIT which will persist. And therefore, the values will be the same if we skip RESET -> INIT.
> 
> 2. I think the rationale behind modifying the QP to INIT in rdma_create_qp() was to enable ULPs to tweak some of the values. But no ULP calls modify_qp on a QP created by rdma_create_qp(). And if one did, the values would be overwritten when the state transitions to RTR.
> 

Got it, thanks Haakon:)
