Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF99942150C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhJDRTu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 13:19:50 -0400
Received: from mail-bn8nam12on2129.outbound.protection.outlook.com ([40.107.237.129]:11668
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233536AbhJDRTt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 13:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrYgelp1NiO3G9Cs/OmMiIiUEo+7lB4yrBG+n4N3YiNPxPqurW2bzDNBhp5lcmkmqSQPqmzvivC3uDPvzEPowjPYAQrukeUqjwojEwBmLTcXGalE/jtyzJ/NXPWYvAon9c/yav8izZ6q1+SWVd5dfFuHOPLIEpt38zwLqvavwy21fc6OZ19Iw/RI6FPOSbegE7jZVlCCKAt6RkXukzStJ7O19DjtB5drV04SLMrcTQ/+9jYwpMuToxcNQSw9H4zapi1bmjt/d9lxBmiBMf+i5PW2oJ52ukwKFnayjgKjtRE3C55mVKSWBzGNHcv01LNjxH+ALNGIz8Vb2Pp0jITN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUr7dUsY0dLVrw+ISg7H7opscRd9aPxPQs8fK2xrDZA=;
 b=eYKH75aAq3EVXhUWFOrB5jMcyU4h0WL7GZslgb+mJhON0nMVeHVnigovo/CxHAiMOEbWMXXr66xxm+r+sbDSpDZhOWzGjfKd9XjVU1IZFs2fOyvZmBWxZcZraMotqsElUnnMaZhg+1s48OuVbmiyM5NufdqnKXZohBe7lE/ivqprreySh7jtpHcfqDCtgnWfjojHvEBknlxqPGhqlBrGOybLxw7eMYojCur8J/A9+1LktLXnKWoI2NeXQcR32SkUBIjg9w5+PxiJ8aJNzYGqeutbtZ8G16EMztOCnEB6MaLx1DnBmaH9ZAXdmYcdTZ9V5QdgUmHd78O8Cv1/6b5hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUr7dUsY0dLVrw+ISg7H7opscRd9aPxPQs8fK2xrDZA=;
 b=lzbGLHUyS6R0j6GYsMeYqZFy40jeNsDFsoT8hgaz+CIUbijyfuWEr6F0OJ4rphhiT41I1jqsv4lOyPHBFua36gKCoEk3CqJo6hlVmwxZadedKWNqAaz/lLmf0oh0sZFov0eOBg00BT/pTQRR9LZkR03RVxHB5CnK7uCdlFDc0uC5RQ2MAaFNaDspdzMC33n7SSMB2l0cHpKlu2IfGvNB4rm/aZ1WNKFMTVx42Wb/g5AgBg9i6P1NWqK8iS8sHkJojp4GssoUgggnCWpye4oc43YQDsK5ELb/GI0N41Cc0JXW+JtgOKVqphlQc/7ktmzTNkfDm0CI4QNqYwTrs904EA==
Authentication-Results: ioactive.com; dkim=none (message not signed)
 header.d=none;ioactive.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6538.prod.exchangelabs.com (2603:10b6:510:77::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Mon, 4 Oct 2021 17:17:56 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 17:17:56 +0000
Subject: Re: [PATCH for-rc] IB/qib: Fix issues noted by fuzzing on the iovecs
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>
References: <20211004115625.118981.81200.stgit@awfm-01.cornelisnetworks.com>
Message-ID: <2d456de4-c137-b00f-b349-5ed23f228b00@cornelisnetworks.com>
Date:   Mon, 4 Oct 2021 13:17:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211004115625.118981.81200.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR08CA0014.namprd08.prod.outlook.com (2603:10b6:208:239::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 17:17:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49f2eabe-3b6d-4fd1-1df8-08d9875ae84a
X-MS-TrafficTypeDiagnostic: PH0PR01MB6538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB653871F93FB10295E2C21D6FF4AE9@PH0PR01MB6538.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8P6oqRPnk7cvpLkzanpMDpvWseL8GioO4NeHz2I4ztyjPCPs6ZwzjGY9ExPvOmdGxC3SQZC4D7cb3Ir8ayFNk18PJ1vccFBQ/gk45WplKKSXxCIGfRx+JT+oFmuygwL2Ji5W1Ax8ZYR1tc236NMRjyLEUYFqxm7dQ6lsxLzmganFQ8l5a9eptcDtajuR0nWCYQINhBowr4CUu3tseaZ2hPZnzi3rWDLKhhrNh84hfqjmZgGwHIH0OicKLeGvU7llGQGNSMsO0YqfKt3EZW5/yAAmvspLx8FZ77v2xT5DxcdW0HZAMpgIcbyy7iI3HgXsWWCbuiPC+mO3geDya9EI3ogdDaoqX3F7iah7Oz+0l43WGPWDGq9RbrWqyO8F1xXbwLFk19h/UBB8FIdXne5a38ZKaaa45hZc9iiorDY68iG+Ns+bXeXgZGCg94RSwUHQwIoC5xdoWuzDg9P6GcB9UvBgq/EO7Ztlq7kRpuKL6EcJqPK8wp1UqTIRb31LfOiZvlLYHHF56Vfd90lr4MicH/fqm8iWVwRziLkX4n6qozSYN+LH62z3ZsZJ6Pz4RQQBMaUtripF7XbV4vMjo6KXSBAuW9py/G4uMTmWMN/Y1A/HgqYXd5xSVIeUVXykERL+LZvwgqBbv8ucoy9noleIClpdNjJCTtSSqoKVrDHg52+IiHqNnkD50aJBW+5GWpSLJixk+eJlGxLiox/ysFNjw8I+owPWHHp+9OBs1Vucgw9JUpIQ4JoTg52k1VvmYz7b0GdRo6EXDiQRwLt/oVRyAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39830400003)(396003)(136003)(4744005)(8936002)(38350700002)(6486002)(4326008)(186003)(2906002)(38100700002)(31686004)(52116002)(31696002)(86362001)(5660300002)(316002)(54906003)(6666004)(66556008)(6512007)(508600001)(66476007)(36756003)(956004)(2616005)(8676002)(26005)(66946007)(44832011)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1JiRERHYkYyMEVGc2c2SVA5SzR0OER2TlI4MEdSM0xjMVgrRGVvSHNiUVBU?=
 =?utf-8?B?U09hUWlON3FUdTMzYjBKUlpoVXJJQkw1ZTArTHFESWlVa0UwMVVlQmQydzFw?=
 =?utf-8?B?dVFYZzlNMVphc0tQbUhMZDY1ZWZ1ZjdlZ1dPcFNVaXN6UWNEdXdCWi90MFIw?=
 =?utf-8?B?TmJPWmJGbHRCSXBFWkorME4xMFBaNGd1NnFjSWZEQnpGNlB0N2JPc09rUDB4?=
 =?utf-8?B?RFNHeisyQVc5ZElnYUJCOUgrV0dBZmRTK2tEMFVxVExTalgvNHhldTlKVlFa?=
 =?utf-8?B?Q2hOdXJzWDg5R1FTM0ZMRy9ad1ZtVUpnWGdCd3JBS3FjYmlyWHRDWWFhU1VZ?=
 =?utf-8?B?K1kxWFZIN0lEYU5TRmJxd3lZVnFYR3YxclEzbWxaZXVYaldDRTllZ2lNcVVL?=
 =?utf-8?B?eWRLT0NidHBjMUtEVkJSMFRBTlJzZDIwMVhiYVRCeXU4UG52eEhtRkh1bHdz?=
 =?utf-8?B?T3JDR1FDRzF5QmNCVW01WXptVVFPS2tldXQ1OU1GT2xLTkEzTjRRem9zSXVv?=
 =?utf-8?B?b0VLbzVvODlMY1k4QjlRVWEwdU52ZEdoUFI2NGRHNTNmQW5yTzRmcC9WbzVE?=
 =?utf-8?B?OHdiOEZrQU1OUk5LVFFHM3dLeiswd0NvVG1lOUZzU3M2N09jNXdFT2Q4M2lu?=
 =?utf-8?B?ZXdyMnJqcEsrVmc3Tk01YU5taVpNcU1oTUZaemxKR3A3RkE1TVRPUmhIRGNq?=
 =?utf-8?B?dFFFWUw1ZSt2dUNpRlg0T0ZoVW9rM25xYS9BbHdXaUs0Vm96VUNwR09WUVNQ?=
 =?utf-8?B?RVJNSlg0cVFjNklONjdZckpab3NTaUhWNDZFL0ZWQXB0eFVKU1FrSEcydlg1?=
 =?utf-8?B?S1hXMXBSSmpscFRJeHJtWlZoejg0VVZMSkhLSnIyM3A3Mnhna3VwdURwZ0ND?=
 =?utf-8?B?Vm4rVzVlMWh4SWxVL2lwVU5qMmwvci9HbEJxeGlSTWhmN1Z2Wk8rY0U3TUxO?=
 =?utf-8?B?Slp0ZVE0V3JHK0l0bkplL05XTDVnTUUwMjRRakI5c251YWNXS0pwemNUbDdW?=
 =?utf-8?B?OXhXbUc3NU1zWXV6bythNGxHbWMvZExMM1Y4RDQ5RDB1Q2F0K0lZNjFteit1?=
 =?utf-8?B?QTcrdlh2L28xVWwrbkZ5TkxSRkI3S2NMcGJzVFdxSU5VekVNdDJJeVVMRHZV?=
 =?utf-8?B?bDRpdWJZN0E3TjNpNHNlS1UrZWNsT0lYODcrTURDemMyNmhzS2lCekdLWExO?=
 =?utf-8?B?dzR0M3A5NUpVMGJKQkNoai93QnFXUXRNL05JT0llZVR6NjRxNElPYjVrcTdY?=
 =?utf-8?B?U25FLzRhQWg0ekZjMnpOQ1FNQVl4aVluTWtBYzJVVmhILzZGVTBocU0xR0ZW?=
 =?utf-8?B?NklMWXUxVDZXUm9TYkh3dUI2UVF6TlZscmcvSXl4aTNIVXJYOVFvMGs3QVlm?=
 =?utf-8?B?UUM1OXQ5Vld4UUxCOWNqeExoWDVONjBJczhoM3ozU3J1MnNmK0c2WThpbzJa?=
 =?utf-8?B?L1VqWitJY1pYQmRPVWNPMTk1SkpqdHQ5UWFCaDlKUlBtU0tMUGpGQk1RTjlS?=
 =?utf-8?B?NUJyWncxVGRtdmN6ZXJuK1lFQmFoRFBEYTRaN3hmTG9UZHVldlBQVU5hQ0R0?=
 =?utf-8?B?M3d1TjlxNUxPODJQRURWaHhMOWl0QklORnNZT0hERVkwRUJNdldKNklrOVhX?=
 =?utf-8?B?R1FFdjlvK1NxZGhMYVFhcXI1OFNkbEpadVBYKzZOY3FVdVpGRnMvTWIrdUJZ?=
 =?utf-8?B?U3lEemhqQTJ6c1hsQ1Fvakl2dVFBbjZQcUZFaUlJZXlLYVF1dkxIQkNxTG1X?=
 =?utf-8?Q?sF9Ak4HTOUUCaSPQMFXZ4zCoLOuAoW9ik+B4CHe?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f2eabe-3b6d-4fd1-1df8-08d9875ae84a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 17:17:56.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fqM+yg1sCAhciI7a3ZrUZJa2fh2Cpzt5wj7/ImwYwhYW+C7XfMJP1Y00/hk8Cc9LtoMa4izo+h5A0eY3cDIUrARuooweNPL+WReklT2kZYGv7GmF/7HUYLmirdWWO1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/4/21 7:56 AM, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> Add protection for bytes_togo and n to avoid going beyond variables
> in PSM pkt structure.
> 
> Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

Might want to add:

Fixes: f931551bafe1 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand
adapters")

-Denny
