Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE442E917
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Oct 2021 08:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhJOGiQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 02:38:16 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:9536
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229716AbhJOGiP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Oct 2021 02:38:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWIdfAnsyMHIaNloRCw4NNBDrUj1BHX4hOXxquyT2kYCaHbOCrfQwTXDjxZs0AdX96cd0i9/aUVo8p+LWr/inAZ90/S4AMrynaGnUKD5ikfafXHTPXyR8CCqV+GkOh8menp7rAPE0gh86lcQQ9LU5gtOFNwSSg3lEErUxsPmLnBMoqa0liyP9uZC5oNvhr3QkKtJL8xu9zRq+5G4evFPE2asD8+jKZ5dowAa8934bTDhz6Bw6aJEb9HwRxFCpxFtxK4LFW89cIRbZELJoAxNh71t5coYuIjZWC7SSsb0tUE9y1yfgs8X5P/87J3/TpOdvRvC/Z441ygdBYTkP/LhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQqMvVVylbeEeKPvTwwjeo2LMpwKSo7uxGZ9zc9Qw1A=;
 b=XtQp9qmZQqTx1tyGgRvmuYilmf9WDCy8PNYjBtn3gj5iUPRbZCHPPHXWPYewmxEQb49fGOvNj/FtCftoKJ+n0SkdnJxfvEoqbFvdFSm/brFpixTNoXfsy7qVOPjvDjWGFVq/LCbBfDLBK3GfitlP96hkOayzlYp+mutArunDzbni4tRDYmwzh2sjMDrLASPXP66PuGDBbSOarAZFvR3LedQE4kjCifw+TYCSQRLnqQNJGPvJcGlIPIzsanVoGFMMQpQm73yr+QlWa2yf/sUWQOtenS1SpsH/iC4Q3y5Uk/VuXHkM9Dki20cZOFSt2wQAho3MBLQY+TDjr8OJRDg47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQqMvVVylbeEeKPvTwwjeo2LMpwKSo7uxGZ9zc9Qw1A=;
 b=PiJvIdhiFg1hyEz8EDLeXR+4mYIcqWgazVTzArrGnnN37+kmtItI+L1hFxzaq39L34YopCOMMh41hDkJZo/EhxcOb+wqOai0rYFHdv4JvtXl9BOWYur0OpDWU8XHu9/UDSUg6NtYJ0+qdB2wUz9rHX7V5+bdv7yHvdmyS47R0m8Cr9/pmWgOfGiPZ59ujkACO+imFcXlaeDCjYvTDt8wj5aaLSu6Lbki5hhKAgGiYmZNB/kjgCvgg5dg4E/xIXuM7s9i3MA8zUFOoO7aurVO8LmguF+1a6c0ReX+8aLW/JCOWGAZ0Zky1Sv6FcXQRyvEk7QXgXRb0cQK1lX/cOBjTw==
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by CY4PR12MB1816.namprd12.prod.outlook.com (2603:10b6:903:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 15 Oct
 2021 06:36:08 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::a3) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend
 Transport; Fri, 15 Oct 2021 06:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 06:36:07 +0000
Received: from [172.27.4.196] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 15 Oct
 2021 06:35:45 +0000
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
To:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal> <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
 <YVG0iI3dSdP/6/1J@unreal> <20210927122425.GC3544071@ziepe.ca>
 <c7954876-8f32-c513-d190-c1822ee6d590@nvidia.com>
 <20210927131041.GD3544071@ziepe.ca>
 <07A724E0-D363-4203-93A9-A5A4F188CB60@oracle.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <99698ea4-c8f1-e8c0-f013-ea5582b5dac8@nvidia.com>
Date:   Fri, 15 Oct 2021 14:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <07A724E0-D363-4203-93A9-A5A4F188CB60@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db9920cf-fa28-4b40-cf93-08d98fa61202
X-MS-TrafficTypeDiagnostic: CY4PR12MB1816:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1816B08916682F92573F804FC7B99@CY4PR12MB1816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjGc0EqX+Ebye7+19g/oFcEHlKWZ3FilCRVxYWgrhAjiGrzicnaVUhjYiH/zGVB6PfZYFelW8BEF4FjTY+UJ9cSdlruQ+YFJ6B3std3fDFNnNs00Y3gRKx4+U5sqW1x6VW4/gHKowd1LP/1auAUc5hQ4mV5s25gyCeARaFxcBzWlISXF3/ZSjEg1rNC+XVOk8cc3CNZUh4+TrXMa+0NstjziRJKV1CkZ25wWTHCpMN2g08zAC55EV5qQ6ZJZtXi7gE3VFRyqH5AzcKJn2H4H2bnXF0KT5+I92HY71Ei42hHNW8tqSPI6WDJUTiYrJarKcNfusuLJrP1jOSz2illVB6XUEPjD1Hhq+bFwpPJ2T2HtDSO6vkANLVuIIuOfA5wSgc6mSoH/xCVhMNhzrnhXUOmNcbNsFyvTB5N5GWzNafaAfC5+AK4xdrpPmlM83JBb+uljc4cNEZRg8Bac+BcH7vXwgGLhkoqzMqlYPF+84abprJ7W4L2euhHM6Rh3Fqro3PdItxmLh6LwaUVaHKlgpU/J8tu3KPD20ofJTO3AUxbNsh++pm7x8elyDp78fi8EjC9Ag7HMby7/iZztkodeXXu9Mff6GPQ0iZGrrwIp2xwZtsdrl0ozNlXVMku0bqVpWyHLnMSvuN4ZCgi8jSLm+1EjCOTpYlCwMfxvZ1sd0zKZMhjbGanN4teJV9qJSELeEMV2OjKHgEKOR/HslsWza46xRAqVJBUVV/EUr1kuxJmSHNIJ6VgB7CgMK+GXesXgvsX8fw+OdgiP+8Ep9ZthALFovEuh/kgPTRhRQ61TzBK51XRg1OW2aTBqiDVvsAEH
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(110136005)(26005)(53546011)(16526019)(36860700001)(54906003)(36756003)(31696002)(186003)(16576012)(8676002)(6666004)(82310400003)(8936002)(31686004)(70586007)(36906005)(86362001)(4326008)(83380400001)(5660300002)(15650500001)(356005)(47076005)(508600001)(70206006)(7636003)(2906002)(966005)(336012)(2616005)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:36:07.2986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db9920cf-fa28-4b40-cf93-08d98fa61202
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1816
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/27/2021 9:32 PM, Haakon Bugge wrote:
> External email: Use caution opening links or attachments
> 
> 
>> On 27 Sep 2021, at 15:10, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Mon, Sep 27, 2021 at 08:55:19PM +0800, Mark Zhang wrote:
>>> On 9/27/2021 8:24 PM, Jason Gunthorpe wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Mon, Sep 27, 2021 at 03:09:44PM +0300, Leon Romanovsky wrote:
>>>>> On Sun, Sep 26, 2021 at 05:36:01PM +0000, Chuck Lever III wrote:
>>>>>> Hi Leon-
>>>>>>
>>>>>> Thanks for the suggestion! More below.
>>>>>>
>>>>>>> On Sep 26, 2021, at 4:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>>>
>>>>>>> On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=214523
>>>>>>>>
>>>>>>>>             Bug ID: 214523
>>>>>>>>            Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
>>>>>>>>                     updates during a reconnect
>>>>>>>>            Product: Drivers
>>>>>>>>            Version: 2.5
>>>>>>>>     Kernel Version: 5.14
>>>>>>>>           Hardware: All
>>>>>>>>                 OS: Linux
>>>>>>>>               Tree: Mainline
>>>>>>>>             Status: NEW
>>>>>>>>           Severity: normal
>>>>>>>>           Priority: P1
>>>>>>>>          Component: Infiniband/RDMA
>>>>>>>>           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>>>>>>>>           Reporter: kolga@netapp.com
>>>>>>>>         Regression: No
>>>>>>>>
>>>>>>>> RoCE RDMA connection uses CMA protocol to establish an RDMA connection. During
>>>>>>>> the setup the code uses hard coded timeout/retry values. These values are used
>>>>>>>> for when Connect Request is not being answered to to re-try the request. During
>>>>>>>> the re-try attempts the ARP updates of the destination server are ignored.
>>>>>>>> Current timeout values lead to 4+minutes long attempt at connecting to a server
>>>>>>>> that no longer owns the IP since the ARP update happens.
>>>>>>>>
>>>>>>>> The ask is to make the timeout/retry values configurable via procfs or sysfs.
>>>>>>>> This will allow for environments that use RoCE to reduce the timeouts to a more
>>>>>>>> reasonable values and be able to react to the ARP updates faster. Other CMA
>>>>>>>> users (eg IB or others) can continue to use existing values.
>>>>>>
>>>>>> I would rather not add a user-facing tunable. The fabric should
>>>>>> be better at detecting addressing changes within a reasonable
>>>>>> time. It would be helpful to provide a history of why the ARP
>>>>>> timeout is so lax -- do certain ULPs rely on it being long?
>>>>>
>>>>> I don't know about ULPs and ARPs, but how to calculate TimeWait is
>>>>> described in the spec.
>>>>>
>>>>> Regarding tunable, I agree. Because it needs to be per-connection, most
>>>>> likely not many people in the world will success to configure it properly.
>>>>
>>>> Maybe we should be disconnecting the cm_id if a gratituous ARP changes
>>>> the MAC address? The cm_id is surely broken after that event right?
>>>
>>> Is there an event on gratuitous ARP? And we also need to notify user-space
>>> application, right?
>>
>> I think there is a net notifier for this?
> 
> NETEVENT_NEIGH_UPDATE may be?

How about do it like this:

1. In cma.c we do register_netevent_notifier();
2. On each NETEVENT_NEIGH_UPDATE event, in netevent_callback():
    2.1. Allocate a work (as seems the cb is in interrupt context);
    2.2. In the new work:
           foreach(cm_dev) {
               foreach(id_priv) {
                   if ((id_priv.dst_ip == event.ip) &&
                       (id_priv.dst_addr != event.ha)) {

                       /* Anything more to do? */
                       report_event(RDMA_CM_EVENT_ADDR_CHANGE);
                   }
               }
           }

And I have these questions:
1. Should we do it in cma.c or cm.c?
2. Should we do register only once, or per id? If we do register per id
    then there maybe many ids;
3. If we do it in cm.c, then should we do more like ib_cancel_mad()?
    Or report an event is enough?
4. Need to create a work on each ARP event, would it be a heavy load?
5. Do we need a new event, instead of RDMA_CM_EVENT_ADDR_CHANGE?
6. How about if peer is not in same subnet?

Thank you very much.
