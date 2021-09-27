Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492764194A9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 14:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhI0M5S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 08:57:18 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:28128
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234407AbhI0M5S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 08:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2nNC4M0+qr1/psm3ykvQXjQDinvVA84oE5bOiAWoTkNMChMmtTeuwBQh5RcvEts+bluDHtvuhYf99Unb7DbHlUNHqAKZOSoyrN7FNFwRGvpaHt5adWTRi2f5TuXh31YYG877KTBkh/ThpKrE1koNFPxntgBTPq/FlCBJRBhy6B+fPYnmWTeK0zMc9NeVujT+cJZDukRnT5dfO1ix69vM3JFXqMcpPCY66QipRgzw/NbrUbHYWQey8IAORNguOGgqU/rTvZGKRIe4RZmzdqAESbzgjlqUNrYnPABHbDCW0Po7iA0Iul96A7dX6GzK+HEWXRMaalDX7nxwy9EkompXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=d7/hybQusoGetGGmKu6JxfCooBE8gT80AGRafN2ruEg=;
 b=Yd0om/334wHPEkjtN4jQ5Gnxx30zD+nGLrMC+xgCY+74hwxTD2miGxqyi2gsdJTCnfLhsj0ASl+Y31+kHtQvUXp/KdHy68oHysYvo5EM7JzGn6WHofoP/52YIyj4Hdy8mjczwCkkwY0sMA7HXHggP1ckxkKN+0RXB0G6nAVSeCzRf5qzLhJTRwAymES9mss/hwXhwzcHlDzazgajpHpNID+mbEH98JHIBO2fI79HeRBn++0odEjoAe/lJnWta6k5EUlZdovFvHgK+I9GNvzcMkaBH0qaOG+dw6T2IPUoAcDDqmCe++mXCNsZ1ELpWNIwqEwJ0qPiuC2iKIYPGGYaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7/hybQusoGetGGmKu6JxfCooBE8gT80AGRafN2ruEg=;
 b=UcJkN5qi9ZZt4DFm4GfsJ+QA/ewuK888pFdngeptvc9+lt9ahmqHri1nxdeK45M8nZrFZQiGkjBo0DPyejUaaKJrAeD3ftibJ0OyYkBbKXKe7ozPmyqZn0IzC4oi1y09dXpEa9bKT8pznf9SRE7FPYSW72R2ba+/Y/ylyK8lr6PXvPNcEJYuEFugSeuZy3RMNcqOr2vP0BorC3LkwNFgUv0AFjGKWanEeWCGX5/9equQH84bmdvM+E+8GTD3YzcumQB2V4kzwllMA6bs+cH8FhSlLNNJldkW8pIWJt5dMuQ/BzCHl/E6xB6dEbD6TaQQLiDwZCfUECWPxrRakeIeeA==
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 12:55:38 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::1a) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Mon, 27 Sep 2021 12:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 12:55:38 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 12:55:37 +0000
Received: from [172.27.4.189] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 12:55:34 +0000
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal> <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
 <YVG0iI3dSdP/6/1J@unreal> <20210927122425.GC3544071@ziepe.ca>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <c7954876-8f32-c513-d190-c1822ee6d590@nvidia.com>
Date:   Mon, 27 Sep 2021 20:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927122425.GC3544071@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5d990b2-8697-4c1b-2e62-08d981b61ac9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5106:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5106C01D8FAFA0752397F8A0C7A79@CH0PR12MB5106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9Q35MW54DHDjF8oeTIhOpckyYhH1nyTCvYbBkdbnR2SV8MPh2GefVeZ0w5qn7QkapE8SI/fUwrhYyVBl3yHbW2UOiv/dosOpw1l7a9HbFBLjZ7gVAly7HsxTMA0ksx91YJhL4XMFk2msia/ZfsbXXLoApkrBI71pJyPvE2exLvHqvotBAMqf/0sW3tbzmMlD0Ye5jJwaFrgNsXLzlfOs4Ah+EdcKZAX0lIR78wgJ8eMoZid3vrOd4ZdYHoQAZqKiy2rux/04X9S83Rwk8hSxe6MVXGjbYieQy28m7StFYfgABjTcqWvqOAksIfmL2Sq1hNN9vh0XUnFEAyk03StafvS1uwAPyUH+Iqw2lVrLB3jscb8+cbRMbi7Pr6R3tR0FGYCdACwfTuDfoW/npftAFTPGyvSRcnNr4blxlNxg4XLEnKo0UK43ZA3zowvWjF3n+OEnXQ5VQv864+lGuNDdqc2MnW0WPdu1zYfbK0fD79wmYBVXIElLVabmYy0/pWjnGMC0Xw+9jDSWA52h8ccI5GnzPNjuaah/kseFhkbOPiXl8zHz9vRl+u8LfPRzxJvPy1/NrymFudWJtVVIJEjZuVESLnLNpfyf6REDmrJGrs1cX+lRaHKv6BkzxKjwOZWWhJbbpJcVWMSuKdyk5dyh24cbndIhLMyWxlSRTLtbmwYAgG0UEgR0DcejfSU/QKU0bR0MLbhGBCc50qUT3nncumXfsoFLxyejAV81miZYVP9TXin7UR3mgFsunbGghBstFYSXZKylNXUQZK+nv51d5rduOtzwn32zZKbmKP7Sk2qaXQZdKpSjabgCnJS4JBv
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(16526019)(47076005)(70586007)(36756003)(31696002)(5660300002)(186003)(82310400003)(86362001)(426003)(336012)(53546011)(2616005)(4326008)(83380400001)(6666004)(26005)(110136005)(54906003)(966005)(31686004)(15650500001)(356005)(2906002)(8936002)(508600001)(316002)(16576012)(7636003)(36860700001)(36906005)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 12:55:38.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d990b2-8697-4c1b-2e62-08d981b61ac9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/27/2021 8:24 PM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Sep 27, 2021 at 03:09:44PM +0300, Leon Romanovsky wrote:
>> On Sun, Sep 26, 2021 at 05:36:01PM +0000, Chuck Lever III wrote:
>>> Hi Leon-
>>>
>>> Thanks for the suggestion! More below.
>>>
>>>> On Sep 26, 2021, at 4:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>>>
>>>> On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=214523
>>>>>
>>>>>             Bug ID: 214523
>>>>>            Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
>>>>>                     updates during a reconnect
>>>>>            Product: Drivers
>>>>>            Version: 2.5
>>>>>     Kernel Version: 5.14
>>>>>           Hardware: All
>>>>>                 OS: Linux
>>>>>               Tree: Mainline
>>>>>             Status: NEW
>>>>>           Severity: normal
>>>>>           Priority: P1
>>>>>          Component: Infiniband/RDMA
>>>>>           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>>>>>           Reporter: kolga@netapp.com
>>>>>         Regression: No
>>>>>
>>>>> RoCE RDMA connection uses CMA protocol to establish an RDMA connection. During
>>>>> the setup the code uses hard coded timeout/retry values. These values are used
>>>>> for when Connect Request is not being answered to to re-try the request. During
>>>>> the re-try attempts the ARP updates of the destination server are ignored.
>>>>> Current timeout values lead to 4+minutes long attempt at connecting to a server
>>>>> that no longer owns the IP since the ARP update happens.
>>>>>
>>>>> The ask is to make the timeout/retry values configurable via procfs or sysfs.
>>>>> This will allow for environments that use RoCE to reduce the timeouts to a more
>>>>> reasonable values and be able to react to the ARP updates faster. Other CMA
>>>>> users (eg IB or others) can continue to use existing values.
>>>
>>> I would rather not add a user-facing tunable. The fabric should
>>> be better at detecting addressing changes within a reasonable
>>> time. It would be helpful to provide a history of why the ARP
>>> timeout is so lax -- do certain ULPs rely on it being long?
>>
>> I don't know about ULPs and ARPs, but how to calculate TimeWait is
>> described in the spec.
>>
>> Regarding tunable, I agree. Because it needs to be per-connection, most
>> likely not many people in the world will success to configure it properly.
> 
> Maybe we should be disconnecting the cm_id if a gratituous ARP changes
> the MAC address? The cm_id is surely broken after that event right?

Is there an event on gratuitous ARP? And we also need to notify 
user-space application, right?
