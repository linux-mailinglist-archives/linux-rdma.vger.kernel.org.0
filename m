Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D420F664DD2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 22:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjAJVDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 16:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjAJVDP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 16:03:15 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2122.outbound.protection.outlook.com [40.107.223.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C235D6AA
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 13:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbJyUit4r1cMW8C8oJC/FB7ptMg8xpWTKi3o0qa0cVnh4PVbPJgN25MYaVKyGlJWduc0LjDvXNmX729SnImyIoNrdiqnMzBVDCpo4x2ELDo9LRKDkgBcACnCqIw4CVbVhXoa3iSsrLDEJ+r0T3YLD4T7zpcTJCP1zEPv1WIqkgh0zDwslXXYKEDnmoBkHrKCcxg+U/Kic06zR/YZw616ZK7XVWDt/4H86HSmk+E07ZtrzOtCiG3IeM78siCztkpd3MwXSadKM2HoyRusTXPDRPj0orDmXRgugu5bioY2d5eCGVmS2yfOrlkg9YdhWU9lIhIt06Twf5jCmb1yKXtjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Py+M76yiGiaI8byE0kl81VrZoeOWhn8OHGaFlA4JU=;
 b=fkIHuAHAtREaavsrNHqTLfAEbhCmhHPy1HonoQ3s5709mw73Ccq/ukwsiRSMUyQ/8wcssoiWgutuJc0TEyMeE7Arf7vMKWHzlVVUC51laSey0ED+CPYk9KEmG6En7tN4tzdcH84oPRYpc2zQVJrmhHRBuwy2iwxUdX+yp4nRWlEl20PEKSRQz9wbflr9FsSpv+MRSLx1rkaHg2c0Tny5m8AQU5mwZZvdpoz8P9LWP0N8iwyJueVSixcIEXExtU94F9L0gEWLvUUVvLaHutLAZ+z9vGir9qG0aouTmURaMzr2+XqwlH0sAlZYBo1awjBOO4uKPg66geuqaOziqNB0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Py+M76yiGiaI8byE0kl81VrZoeOWhn8OHGaFlA4JU=;
 b=St//AAhlbx1jkWIH0txt/FjoXPnFW6ntiLQH8Fg4INQb9LERADQsn+wlZNSGgB6tF4pVFFOti0eDkS/db5XlZ64uC6KfcPkc+hnMTOD+S46x1g6kwQNdwnIu+oGLP/IDlbRyKY/5bB047/18dNcbJH9YjWv5oveXpaL5EhOsnK/nTKle1K29vq5oyTZrIYWIUZdIlm+ayzHi0mirv2guT4/1iqeQx1hrvT+m2e42UTXb3MjMWgwghI9ZgBkjDSoBmU1OZR9NCxQ7amryZzBQPH/NHTuRSP16XlfY96v44LUTjoFH0fMmlx3JQ+ITiPUN4niwQE3nn4RXTSw/F7ZqUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 SN6PR01MB5312.prod.exchangelabs.com (2603:10b6:805:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 21:03:10 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 21:03:10 +0000
Message-ID: <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
Date:   Tue, 10 Jan 2023 16:03:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y718/h2uSTYq5PTa@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:91::30) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|SN6PR01MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: d24027ea-a40b-4eed-d9e3-08daf34e1414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9AkyMP6uE6/L+QSwrCbHmnxTrrjuYSLm1GZiISMAC4ABlcIPXUUqbmL/11IWP1vzzVIbhoLVkEJcMEovxAfYEKVDoJ5VCL8tRWJSP4bh5DUskj5qyi2K+/g6/QZWR9Pl+CTaS3rH6tDS3QtOREskyzx3ZGtTZgqnm6fiCQdJtLdk4GUNyC1H0PYtJmrn5lTuqz+o4ZWllXi9ecEvbavPjH85ovfzMj9YcvNGfVrNhPN4Y8h67KXJphSTPV8BnuNLGSd4m7XI1S8skF4q9ahTr+XUlWH8easHRcR64ckDNG0HkciDbMrv8o+cHTA3uDDXLP9WODzXNiEK2At6VPJ4IH/LbN2KgdiK31EdnhokXmwSFxyU8qyPMyZtZOhcsju93vLGIKHd4MkJWAVFbI4vOL1OLb2+wubKRLnaSYsGn4aRXTA68ZYttNhe0DhLY6FYZe0+LzncI9ZmDVNbwW+wy46nmdG5C8rhRUdFlgge60MLXeZvf3SCzNAfeXnlx+HsUgkn7sJQNWduk/qeXcWUr9dAaYRiEgndYuUaeTXzcPJAbgUfiB43yO4XI90TA5YH3TZYP3zDLhxOw8fQwFElTFZijGFalIWaGEIfhEV1UKINVrSZya70gcSdNwJ/yHtwx8tl01l4p/00wV1EOK0BqZJw2k6+SPjZrTJCV+ouS88PbZfNeuGMK8xDiONZ0VMQBmnXtQd6r1PFnKNhZ36CaeCvQueCvd2vJ+cWzWoeiXZdexHs8op6OYlkECquVac
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39840400004)(396003)(136003)(346002)(366004)(451199015)(6506007)(478600001)(26005)(6486002)(53546011)(186003)(6916009)(6512007)(966005)(66476007)(8676002)(2616005)(6666004)(41300700001)(66946007)(4326008)(316002)(52116002)(86362001)(38350700002)(38100700002)(31696002)(66556008)(31686004)(44832011)(2906002)(8936002)(5660300002)(4744005)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ViSEl5Mm9JWXorOHV5bVpxdXhYVVRJanhPN1Uwc2NpNmFjQUY2Wlg4OW5u?=
 =?utf-8?B?YkhGL3hSVGpHWW82L1h1TkRoVWpVZitCV1AzcHA4b1dZeklCVEl4bjhUNVky?=
 =?utf-8?B?Sk9lWDdicnhmQW93Q3REb29GMjJUMEdDOFhBOWlYSDJBeTZSaXYrbVBlay9s?=
 =?utf-8?B?ZWlrQmg5T0VuY3IwQkgwL3lucnJWODBqeUZad3IvNEFUdjBRTkdXQnRYbnFq?=
 =?utf-8?B?SmIzZWlHUGJEdG1ZOGthL01Id2FPc0xpWkE1QU9CQ0o2ZE5GYWl6a3Zza1Vt?=
 =?utf-8?B?SlJLVXhBOE51cThUUHIvU1ZJNkhnZVNWVXdRczdwblRDYTVGNWhmNFlML2Uw?=
 =?utf-8?B?c3pkRVZFYy82WlJmTU03cWVtZXVFSlk0a2dvNmNhdENCYTE0RWt2YnJ6V0VY?=
 =?utf-8?B?MitWREVzcFc2QzZGR0hxeVBNRXNzLzU5WDBmellSZVR5YzdWMFNodFptUk1w?=
 =?utf-8?B?YzMvbWtrQWpDM0RTbkRsZ3ByZjJFS3JSWHVDU2J6SXlZUGtsbDhwUnRxNW9o?=
 =?utf-8?B?RTV2SzdkSTIyc1NoZ1FBZGxsSjZoTnhia3NtcWxpbFpsY0RpZUMzSFJKVzdl?=
 =?utf-8?B?MnFXOUhqbm00d1RNbmhZNVVLeDc2Y09KY2pyRFQrOFJYanZ3UWtSNHNMZFlI?=
 =?utf-8?B?NzJmT3U1bTZxVm5lMW5DVHIrWHJlek45bjRMVGk3NjhXUkkvaUN4R0xTTVU2?=
 =?utf-8?B?WVNkUHJvQUVtM1ZaODRvMUNYek4vcmw2OEsyZHYvVXZsRkZSNC9CVUJGb3Nq?=
 =?utf-8?B?NEdrMjk1by96c3RBUVE2TXAxQlBkYzRsTUxZN0xKeHhaaEk2d2ZYMXp1QmVa?=
 =?utf-8?B?WTZxbC9iMDZwWnRndHRMTUZycnZjMW4xdG1SSWpKSXpmV3NITmpDTTQ4czc2?=
 =?utf-8?B?TnBqNENJOXFyeDFoYlF1Q29EeWJzdW1UaE4ybGsxbWVBS0l6blE1Q3U4UHVo?=
 =?utf-8?B?TmcrVktwU0FoQzA2emdyOWNYNkFjM2VYL1JxQ3BVSEg4NDVOZUdVakw2YThB?=
 =?utf-8?B?K3A5dVova09CYUQzSndsOGFnN0RaSGJoYU1LTkVxVDQ2RTZEa0ZYUmlZWm9J?=
 =?utf-8?B?WjI3c3EyN0hlSDVHTmpTeGpsL0RsODZKcldRL1ZiZWZkd1NyZlk5YXpMMVFq?=
 =?utf-8?B?TzVsZzRwcGo4MnBqSDVmQVFOYWhZT2JOc1RjL0l5K2gyM084Zk5tWDNKdHVI?=
 =?utf-8?B?OUtDK3R2SG1UbmN4NXY5YUJBZEhEd0pqdjZPcVEyOFZlZCtkNGx4Yk96Y21Z?=
 =?utf-8?B?a1QrZmtDRnJVbjhHZHluK0plM1RqR1VGTmxUZnJMUDlMTFpnSGNya3I3ZmxP?=
 =?utf-8?B?M0pFckp2blpSQWw2bmxZcmdzKzAyc2l2OFRWcDBTTE5PYXBKM1FYMzRIQlNW?=
 =?utf-8?B?WUVvcXFQUStVd0Vyclg0V0Z6aEVaYkJXcHhOYjduY1BZWXVrcHhjK0hSb2kx?=
 =?utf-8?B?azM4OE5YZXJlK1FxUHFXY1A0N3NFSlRUM3pzV3RFWHJua2hhME5zK29Kd3hO?=
 =?utf-8?B?QktBc1QwNWk2dlZncjFLUmc5ekFoYW0rWUlWRy8rVGI0UW1LSGxkRjlQNW5E?=
 =?utf-8?B?cWNHcUdJdDZXcURaT2diLzVBRFBYVnlFQmVPT1RZeXEzOUU2azFiYVJjOTB6?=
 =?utf-8?B?QzkvWXRNZ29rdjJ2NUJIRmt3UzNlZERBdFErakJPNzMyTzdWUTBmQUR3YUZ0?=
 =?utf-8?B?bHNRemV2RkpZa09LKzZvM0FRblBKKzloU2p4bEhaYTdnWEFKNTI2QnpWejRL?=
 =?utf-8?B?Y1ZYUzJUSzlrRWdhaEM1RS84OER6VTkwTmVqL3IrWFltK0tFWlZpam5LWkdT?=
 =?utf-8?B?VDFIYnlaTWNTSjZiNFdEekxLazJVUEhaQllrMVNHLzlUbFVPU3hqOE95NWRB?=
 =?utf-8?B?RlJOS0tSMzBlL2tuUlRQZU14dHlucVNCRnczMm9jK2FnWTl1WU52VWZhS1A4?=
 =?utf-8?B?ZTFnc2xGQm1mMDNBaVJoMjhMZHgvMFJLUkYwVjNmM3gzcGhXWkgvemNJbU55?=
 =?utf-8?B?b25rY0pxcXRYanVESlMzMGUvWEltNlJTenNzamdpclgrOExaZWlWNHNJODBM?=
 =?utf-8?B?WmFRSE04aGlneHpTQlJlN1dWZENBdG1kRHFkRk03MVA2L2NYZGdLK0xKYkxo?=
 =?utf-8?B?RzZFQmY2T1Z2a1NITnhLR1ZyY0pUNEQ5OVFzVmRLTEJXMmhUNjVzN21Ha1VM?=
 =?utf-8?Q?xudiswTqxKzQtEcZYj8qcp4=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24027ea-a40b-4eed-d9e3-08daf34e1414
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:03:09.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpULe2aSG0Pt0D8HfC15Eao8sjLn6twDSZMThnTXVaF7O4o1va1fCHo/REZUw/dgPP8Gyns+bpXbmL+DY0rqzs8mzDamNYTLF0AOMFQzH54Goaaz69Qauv7TCUb57/yh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB5312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/10/23 9:58 AM, Jason Gunthorpe wrote:
> On Mon, Jan 09, 2023 at 02:03:58PM -0500, Dennis Dalessandro wrote:
>> Dean fixes the FIXME that was left by Jason in the code to use the interval
>> notifier.
> 
> ? Which patch did that?

My fault. The last patch in the previous series [1] was meant to go first here.
I got off by 1 when I was splitting the patches out for submit.

[1]
https://lore.kernel.org/linux-rdma/167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com/T/#u

-Denny


