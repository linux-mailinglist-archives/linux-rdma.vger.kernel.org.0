Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B74353738
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 09:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhDDHmI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 03:42:08 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:41234
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229550AbhDDHmI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Apr 2021 03:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n//U5sfh/9Pf5T9okrwGiT8ecV6IniBtnKrCgobdNMu8awDOzfNFtaasNn30VmwQ0Qo6TsQ9/KZqnDzT5/XKRECV+1AY6GVwZMoV/xqECsQu42BfxW7rHeTVeWtz/VWKkafFzu+htSXsKiHvVoMiZGqUdVT8hFcNBj1RFIs09BsUnbBylO6a65uomyxsZJAdg2DERhz5wOZVtE/PCBLSvi6Gb3YcblT48PxwNJN5Vsu6OJgzFCqTlo4r5gE0v+TM2dvMTt+lcgRhy0ShLGBzZ8uJviutPDFEKM3ecEkMqKiw+F2Z2SR00crQmFTFsgmMkR5/Fui0hNmTftpc+pECAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM5xQi5OpYT6a1dVi/GMAdvyr+VFQkcYi9Sj6geW3Ow=;
 b=GjAtHJoncvOeDfdRH2ffbdDuV+hnDrQ3sRRFf8SnrMNalBjlrN3EXsWkyzY47q0ALnQp2/+iSwt5LgtDxL+kFEOtb6rVDKoCKRspPWNBLhyAswVW1RpsxZ2LB8Pu5F3NbH/VpEREqZMyGNnwb3oo3gIb60djZZBW/EdrrcMP8miR8zs/S6a+jTobz/635NUidBYzjw6NAx5JlHwA/30e3WdktJFIkdG+/LRI6ai2dibhp3Bjg0NfleWGNjZaLAYaka7svlBpSdEGDvpt5L37o35a5dt9yfOBzrbz+I+QFEPCjlSPM9dPNv6tyniivI2bQPwNcIs75p1M/HrFjZWB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM5xQi5OpYT6a1dVi/GMAdvyr+VFQkcYi9Sj6geW3Ow=;
 b=Nu8GNeqZEkANQDxwWC+GLiVNTwdmGRTvb6kfm4FL7WTHF+YCrBtk6kBEtxy1toJdcPocKiaq3auGB/DCEePyR4TgwKV2Pbbh2mbFkYBNlMvcZk2FxdOgtJ7qZfHr9kppAWrl8KdkpQKctV5QfN1aiExGzZuoWKTz3tPBX7FioapIIN+6u7jX0tYMfhZNDvnvwIILauPlwb0WMzeHBKpa+FGGcni2JCTBLb4tRzIiX5C8s9/iTFnwgqHfsWxmO4enC552Ial1m6CBQBPAornp3H9NAlZ2To3FBWHdJGCuDgTotFtGI+mpSd2SgIpo38CofwtFJoyhGkYz7SK+SfBjgg==
Received: from DM5PR15CA0040.namprd15.prod.outlook.com (2603:10b6:4:4b::26) by
 MWHPR1201MB0208.namprd12.prod.outlook.com (2603:10b6:301:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Sun, 4 Apr
 2021 07:42:02 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::77) by DM5PR15CA0040.outlook.office365.com
 (2603:10b6:4:4b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Sun, 4 Apr 2021 07:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Sun, 4 Apr 2021 07:42:02 +0000
Received: from [10.26.75.2] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 4 Apr
 2021 07:41:59 +0000
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
 <20210330201245.GA1447467@nvidia.com>
 <d008b9f1-ba94-725b-2753-d586a4e400bb@gmail.com>
From:   Mark Bloch <mbloch@nvidia.com>
Message-ID: <7456d7f7-628e-0393-eca9-726c0f5a643b@nvidia.com>
Date:   Sun, 4 Apr 2021 10:41:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d008b9f1-ba94-725b-2753-d586a4e400bb@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ac057c4-2c35-45ae-977f-08d8f73d22ef
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0208:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0208591576B3123B4504D629AF789@MWHPR1201MB0208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuLGfk+J8rHGlzzu0AoBiai/UkM2M4eNsUWcX/eIlrfTMz7G4ddFS95j5GCUCuUQw5clEuHkXe1oyN0OnHvT1OTKlSHI085mwDdwf/Rx7Z9V/k/f4v1+wGuxvYsJTXRRwgLuQ/z15RpifQ8kuUgFr4C82n1qXNkOMppkuY0wXCChc1G0VB9lR1N7Kn0st/syd7emgTZyEhh/ZTLejjd7Mu8msxCW4/yrifXZYO8BTlrqbAHdYhp7eXoiqRFlRkkZkCnvVsYhf3jITQLlIJRkY3VXYFUcKwouEMQWP8eCLitpLyz5/NwL6UOgukx/uVn25X2i6yQkBEGsukmt5BgCgKnmo441mpNgHtAbPRLLjVFABwWg9tl7ym6xHNwTpOZs3qWMUoxxRN8hmYuuPtGDly2dXSlHsKypaRVo64Rih/quOmX+yFKeJIKaV46DSa4bNxmEE0kO5/F4wkuCZnIVzbXTVbqcAjdBOJV0g/185Kc07FKie+jAadz5VuGhiC3lkZytFWMqvv1PBNckkYIC5OrYfgNtUuJwitPF+URcxSh0CLy1oVNvFcQToPJ+FUzzA0Acoi9jUe8aGjhzwVOGXNuqVG6bzyCdf8eplg/Oh1j2GqDBc80LJXe8lk2vmLhW7x5qcepCRpfCFAK9ieYBIIlBW4To+/vXAKPXlJN5L2jk16d9/UVByxChwacQjN5vk+b0wVhpgdEJTiXLRITvfxVOiythTh3XzyPVIjv4d6rrgq7nDKzsujYGJTNsBVpeqYwtkLVUKe4IsR3Crb8U2Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(54906003)(36860700001)(316002)(36906005)(82740400003)(31696002)(47076005)(966005)(86362001)(336012)(16576012)(6636002)(110136005)(478600001)(8936002)(2616005)(5660300002)(8676002)(82310400003)(70586007)(53546011)(2906002)(426003)(6666004)(356005)(4326008)(36756003)(7636003)(70206006)(16526019)(31686004)(186003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 07:42:02.3068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac057c4-2c35-45ae-977f-08d8f73d22ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/3/21 10:00 PM, Bob Pearson wrote:
> On 3/30/21 3:12 PM, Jason Gunthorpe wrote:
>> On Thu, Mar 25, 2021 at 04:24:26PM -0500, Bob Pearson wrote:
>>> In the original rxe implementation it was intended to use a common
>>> object to represent MRs and MWs but they are different enough to
>>> separate these into two objects.
>>>
>>> This allows replacing the mem name with mr for MRs which is more
>>> consistent with the style for the other objects and less likely
>>> to be confusing. This is a long patch that mostly changes mem to
>>> mr where it makes sense and adds a new rxe_mw struct.
>>>
>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>>> ---
>>> v2:
>>>  v1 of this patch included some fields in the new rxe_mw struct
>>>  which were not yet needed. They are removed in v2.
>>>  This patch includes changes needed to address the fact that
>>>  the ib_mw struct is now being allocated in rdma/core.
>>
>> Applied to for-next
>>
>> I touched it with clang-format first though, lots of little whitespace
>> issues
>>
>> Thanks,
>> Jason
>>
> 
> When you apply to for-next where does it go? Until it shows up somewhere
> I need to apply the patch but since you changed it I don't know what it
> ended up as. If I knew which tree contained the patch I could figure it out.
> 
> Thanks,

You should see it here: wip/jgg-for-next
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=364e282c4fe7e24a5f32cd6e93e1056c6a6e3d31

Mark

> 
> Bob
> 

