Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE652B55A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiERIjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 04:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiERIjo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 04:39:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CD1F62A;
        Wed, 18 May 2022 01:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsVbeOLw3rrADNA3f6sYvthu7/DD1m4nUnBEbBLL5nJU/ak6rPOtKEHw8hbvxyMEDMIQueINUkVkd1CS5h8EnpUa4ILgxqZTPm1JZePldG+3aah58aYcRt6toOcNhbSzeutygvvoTAYR0RmvnvQB0QBtkFJ3v7Kr8PKmuDJmVcrzNh9SqaGzxZcSuO/7YViyDZeImEaoSlCJFBGEUTUTSnUkuW63zWKcaXJtKsRcOEEDKPn/wsrw+bSbvuFu/eTicmPyYqO3MWn+AO81O7eDX0CWBnSZhB1ICURNpKN7O88HrJy/BnogglN6XDKtKibk0FEAwogeNnXrgQrx3NQypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4XqEsxfNadVrinH5xV1fCns5JSjDvWlPwGMtPqMRKg=;
 b=PfFsDwEPSDY4p8A3DOoT8st835xj/ErD37sctRI64eGxvTLveAPyaT/gZFBpnbOiTWQQ1kzCmyB7gg1jDUJmg28g9HhQL4F3ohogA/z9xt2YhT3OL01rZggTHDY6QVEsR0ht7il2dnfwXEE1/BMCYXxSpEPtUuLO0DoirCX7WZZL+s/5QNoiRKB9xcDE6+Dlpdf7SqpOMVzNfauPMvYUjvQnuMxugHvKYrUvni0Dvk3fNirKhnXDGjpUENPPlzN40kwwzYue0H9KC0YU6tmsLLrbt89Vxp8GSxGSDrMWN2aZvX7ldDH0ijRjKpSbVzjHz1hqLmRCmR21LQrMbH9EeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4XqEsxfNadVrinH5xV1fCns5JSjDvWlPwGMtPqMRKg=;
 b=b9cfu9K+ReNeAPkpV96CzTuSj4t4dpVFlt8aimncBq6vtTSMdbDYxIXy8rK5q94Y6v4j+CzWe2vxIKmVBU2YfqN26jyYoO4f1KVo84QTNyrQOD8TSfIGjPfWcbjAEUpYGau/opvpQnBC+hH+puKyupBEE5fOk1HioDP5txWKoflCB2UgftCFW0CEFJ99ao2Sj67QDkhSLHLQQQCa7Z0PexeH9NDPW7Taduchn28AUVrfWxPoMSIw5PfcJeWWY2uFHZfNqwSKbeqq8BOnihfPceLN34fzIFivfYi7SF0fYb8cMvvEjw4a0l9BWuO5tZVoWfOiRW4FwqSjgHEGlFN+NA==
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 08:39:41 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::44) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 08:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 08:39:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 08:39:39 +0000
Received: from [10.26.73.65] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 01:39:35 -0700
Message-ID: <733b8116-ed8b-19a7-fb28-cb412ccbdede@nvidia.com>
Date:   Wed, 18 May 2022 11:39:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] net/mlx5: Add sysfs entry for vhca to
 /sys/class/infiniband/mlx5
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
        "matanb@mellanox.com" <matanb@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "sean.hefty@intel.com" <sean.hefty@intel.com>,
        "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1652137257-5614-1-git-send-email-rohit.sajan.kumar@oracle.com>
 <BYAPR10MB2997DF974EF3631A2E69CA3CDCCA9@BYAPR10MB2997.namprd10.prod.outlook.com>
 <Yn85iFNS96yO2ISD@unreal> <d37309bd-c7e0-8e15-bae9-9341f4f9192d@nvidia.com>
 <YoR68a8aN5Ld5Jv7@unreal>
From:   Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <YoR68a8aN5Ld5Jv7@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb2eaa8-81fc-4eb5-f93e-08da38a9f30f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41913DB362F2EF71A57395C9AFD19@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23pDzcg1x1zBkXbA0jt69P8XshGdVyq0evxTTUGDRLSVGP8w3k3+l8zUoXd8HMZO8i1evCqkzgjonPojK6uqn5KK0CZbQYcuRC8g5EsQQ19NsjLJ1HySdXGOQRHUtpPYSAIqg+0sZwIVjGgn41+IERZ0GhUYWov1QjBeK4w7NC7uQ0uCdbjvuiSbWlB3OzH1LfPSs60A0GgB+0XVc8LZh91kZeNQbgWq58HK7dJgvf58tqm6yX3l3HY00aVbo8jEys5io4vm9S1OyDl4m0Az4IVEymTqN3BJA/Km54ep4Aa3lMqKxP0V4iIIXg+Gy3RQKc7W2u/bxjw4yM9/gncaYTV1fDWSVgV5gF0/93yTyuM+qbCrSAex2B6FwYGenZWLbqq+H/+Uj86uBLOVOU2LAyepzajbqlX3OqymzWnemXu3xeHV2TZ2yMYF9Yoks6mst8BPB0AUH3gFhsOrnMeM9EOdighVQoRkOSTOF26hB8u9PcaJX/uh5YeS6rvMkljrX+m15k5rntXfOir8NR9Lavmt/QESoyGzKclibAWlh2tZkXrc9JT+wHE12zQSz+exd/rOWfZHlOYYapwZp/U/9FJRzVZOH2oTJkyHjoW/SpzwCNZOBnImgvBODUXq+EPXMjTC1Zymvdpo1rPBlP8P7/qpYLFJFrthYs7rh/I2FloRgSH42IyFgwQKcBnp0IozpVEqrJQyId2KAJ1wtWoeWGzuSI9NSoCB7OwQSU1WxIm2H0u6qRSeq9YCbnJX5zeh
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(83380400001)(316002)(54906003)(6916009)(40460700003)(508600001)(47076005)(426003)(336012)(36860700001)(4326008)(70586007)(70206006)(82310400005)(186003)(2616005)(16526019)(86362001)(356005)(16576012)(53546011)(8676002)(31696002)(6666004)(5660300002)(31686004)(36756003)(2906002)(26005)(81166007)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:39:40.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb2eaa8-81fc-4eb5-f93e-08da38a9f30f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/22 07:49, Leon Romanovsky wrote:
> On Sun, May 15, 2022 at 10:36:07AM +0300, Mark Bloch wrote:
>>
>>
>> On 5/14/2022 08:09, Leon Romanovsky wrote:
>>> On Fri, May 13, 2022 at 05:46:16PM +0000, Rohit Sajan Kumar wrote:
>>>> Hey,
>>>>
>>>> Sending this as a gentle reminder to review the patch sent earlier this week which can be found in this email chain.
>>>
>>> Patches that sent in HTML format, to wrong addresses and not visible
>>> in patchworks/ML, without target net-next/rdma-next/e.t.c., with wrong
>>> title are generally ignored.
>>>
>>> Why vhca_id that returned from MLX5_IB_METHOD_QUERY_PORT is not enough?
>>
>> The driver returns that only when in switchdev mode.
>> I don't see why that can't be changed but that's the state today.
> 
> My guess is that it is not needed outside of switchdev mode. This is why
> I would like to know why current solution is not enough.
> 

The commit message says this API will be used inside a guest.
So they have a PCI function inside a VM (could be VF/PF etc.)
and they would like to get the vhca_id of said function.

The current info is filled only when in switchdev mode and only
when run on the eswitch manager. If they want to run it on a VF
it doesn't matter if the eswitch manager is in switchdev mode or
not, as the VF doesn't know what mode is used.

The query port method was added as there is info (like metadata c0 value and more)
that is filled by the kernel and DEVX can't help with that.

As vhca_id can be retrieved via DEVX and requires no userspace/kernel changes
it seems like the best option.

> Thanks
> 

Mark

