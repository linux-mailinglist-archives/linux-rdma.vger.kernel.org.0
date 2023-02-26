Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612F6A2FE0
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Feb 2023 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBZN5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Feb 2023 08:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZN5Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Feb 2023 08:57:25 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5759113F2
        for <linux-rdma@vger.kernel.org>; Sun, 26 Feb 2023 05:57:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU0N1NRBa1UHQ7DTpHl+MplUbGQLcKhzRggemYr4wtsmOeNLhmLgfaJHzk3gYX8RuMc1z2iHInk8D7+WvIcTRzfF+CElD3kWWPgyS0A/3eP2bl927UKKujYru1T4rfIgUA6J9f5Gr7H23mLbXL6EkxbqkR5fnXLfC/04ZNmmXqaz642gCnOZaIXbR2JJ02nTKT2adEQif3lANGV4fmsVTSPHTW98BZGlM8YzwNb6jdFqc04X4NBdi8a7T/YPMhb5q7P0qDMjdz5753tTkuvOQZBqZL2pwlkI/whn6gHYy4ruskJSTV7f7XedCvoWPOzCrAIS0CeCvx9fZvEkS0K3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPmOBC5BYMHxuHr1NnV5cHlQhBRvJiz9h2kIzvPKqQo=;
 b=PVpYhkFcK1wMYTCWixv3IB/43EJsoW6s+k1PimUiZxnOPNn4pkd9/9dM7a7vP2g4T+lBBcAjkaBjoXPL5KYtw5e895Kl2gRXS6Bzs1nxM+oJ7aixI6axMCJ9KoZjRkZSJDs5+6ZzGXx0ApLiidq2EtNkDTlyaP9SydUbxk8NkoGpScIbbP9s6CGVCnrXYQK6+IwWnDXuqQNrM+WwaQSmLkaP01kYv/75NXaYTmkBKcjEWefX9805zghsGyRYzZhn2FhOm3po4EP+ERhTy4KqDuhPvpeSTo0KofbUNf9ZgAJxNmCHjnCMaWSJUyeLkz0DawPcHxfEV2v3ZD+1WDOZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPmOBC5BYMHxuHr1NnV5cHlQhBRvJiz9h2kIzvPKqQo=;
 b=JFRLldwpDTF6hFK0kdWTWRNZHaHhOQ85dW3fFoAioAqMIOPW2Dpr+SOzLyuvSj74VP6U+YlE13dJEWEa1kWZJYAI5wW3Hi1zkVrR1q+PYxbhJ6NoJbn/ENy6uJUnLt4gqD5Vl4J2UmRuLgMR5AP6clZ74BltkTBovizsW3v8AHkxS9mN9w27Eu84KFXofNrQrvqyx0/Nys2WMOSg7xsh49nuzs8uloKCaKyeTLFopIHmK/hG3kvmICfRT6R8yN5F9YrrxECGhTzTaJqX1oJQnSDc4SlSowQbNf4TkaLvkFLZ3cvUd4sCheAYcltw49MA9eG3NRatdcjiIMZEe2UqRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sun, 26 Feb
 2023 13:57:20 +0000
Received: from BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::75a7:9c68:f95f:9fff]) by BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::75a7:9c68:f95f:9fff%7]) with mapi id 15.20.6134.026; Sun, 26 Feb 2023
 13:57:20 +0000
Message-ID: <afd9c082-db31-da9e-8cc9-44410d110ccf@nvidia.com>
Date:   Sun, 26 Feb 2023 15:57:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: A question about FAILOVER event in RoCE LAG
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        "huangjunxian (C)" <huangjunxian6@hisilicon.com>,
        Mark Bloch <markb@nvidia.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <26b0d23202814f60b994ce123830353d@hisilicon.com>
 <Y/tWPpJNz3EHtMgB@unreal>
From:   Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <Y/tWPpJNz3EHtMgB@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0199.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::19) To BN9PR12MB5258.namprd12.prod.outlook.com
 (2603:10b6:408:11f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 7682df99-3b3e-4db0-11f0-08db180160e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFwts2GQn9JQzhfJMEpg/DigeCuRgqXWVgrQgu288NYLqx4xlikjyPyJ/+EmccTXyILSWeaRnrxlu8vrNNYqUhMJhiCnbTBnqfd+1tDjhHSSMsbmH4RcGRuas38dxCVJVuNciHIMzmDL1oBvDz237A+eUWVH82O4U/hxgKERY/fbOuVBWKSU7RgZKSW0a295wG8tr6L3SlPz0S+eqMDg4zsUXXlMnBwO6AP2SnBmSPZ2P4tLNHTQRia7y+KvFq8CgwORfkFtzWToNYO/vkFHOiifDFMogwa8GWg/UHWavTT3s26/I9exCZg7A6eE1uFLFNUgi76i5ymG8wSHRNCORmyXQ8tEqeYuaqY8a/2Okrs7nJwMuC6BUYZ36O/z0+imZ4l78sD6LXZlhdJZyE71e+LrrGWi/+MViMJaYc09BxOBhIMlXhlD/h5CRFYrq6wn4ckCwNrA4FW2Yyido/yccRlTys5ollh7GfPw9Jq2zblXt7kdZ5f9SN5BoHzcjIJVg0/zOpE7IO3gn6RtPwGUtTTCIBhfjtBVtdwQnHqxEbzj0ss4CkYzpIrDQf0xGrzFqK8zPe+FGAp7EgZvqv3F5FaX4toP8lUN+GyZKAMk8nHyg9uSMg7KogP/4sqF6GG/KEIA7dx5+eQevE9w1j5rqIRHN0bs2PkUbcRfI1q53hzT9xpWkBy3Z5AUSWif23M1CcFd0gLFxLVG+2JbZU9wy0G1UtxKV10EITVd7GCH0DLQZaMQMQGkfDt/fdS6R03LAjUGosnvOzgqFrSKm3Y6TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(6512007)(38100700002)(66946007)(8676002)(4326008)(8936002)(41300700001)(66476007)(2906002)(5660300002)(66556008)(6506007)(186003)(26005)(6666004)(478600001)(2616005)(53546011)(966005)(316002)(83380400001)(36756003)(6636002)(31696002)(86362001)(54906003)(110136005)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5aYVF4cXRtZll2c2lRcjNPQm1Za1hzaldUT2NsL3RhckJHY3dISzh2Wm1y?=
 =?utf-8?B?dW1sNFNDQ1RpOFhFby84bEF1Y09jOEUvMkdYamxWaVIxNXBGY216eWVrd0NJ?=
 =?utf-8?B?cnpSSGdRR2kyQyt2TXVNb3RUWnA1V2ZPM3JGeGhzc0p2a0JBaFNpZ0RlZXlN?=
 =?utf-8?B?YThrT01GZkwxb1c4Z1orbGdHWU13VUh3NkQrYUFqSjRZalNNd1pQL1NacHdD?=
 =?utf-8?B?TU9YanhOT0V2VHhzbHFwRHlKUUN3M2VQQ2dkNUhOMEh4ZE9XWHdGeXAxeXNX?=
 =?utf-8?B?cm1UZ1Z0cHI0REF2Q0lWTFpnMWFHSDM2RlVsMjVNU2d3NHZjMXRnVzNwWDNn?=
 =?utf-8?B?WVExTkpxc2pxaGlzQnF0TE5yaWlwaHJHT25FUWNvamxackhBV2VXY1pyTHZq?=
 =?utf-8?B?dUpUSU1jdGhtTkFKL29uUk54QWVCbDNjS1RrZmgySEJHemNGYW50OXV6UFUz?=
 =?utf-8?B?NWthSTljNVVnZVlOd3dTRlFaWUd5UVFQQytFMXpJQ0FrOXpnYVhNbG8wWWYw?=
 =?utf-8?B?MFBRKzZaTHowN1UzRkZkZEhzTDRTTWNSd1lRWTZSb05JOHVNVVg0eWtaYytK?=
 =?utf-8?B?T0V0SEFHTlhTU0ZVb3NLUzZGN2MrTk5BcmlzeGI0T1J0MmdQQ251eGxDeGxM?=
 =?utf-8?B?ak1VdnVVMGNGdndzeXh1VUJRb2cvZS9LZUxzZlNyZGxBaWhUZ3BpUnNaeUlm?=
 =?utf-8?B?UnhpT3R6ZEF2bHA0aVpuYlpnT2poaEFONURpVlhaS0RNK2tnUDdqMFc3VVph?=
 =?utf-8?B?bEdzcGZhV2hqMmZuajg5cnYwZlNzSlVoRXpRMTlWNjR6ZW1ITTZLb2xwcVBM?=
 =?utf-8?B?RXcvdzBBQjhKQnNIcHNaa2dETW51SHRyREl3QVRMd1cvOXhXQ0d4bkY1eG9X?=
 =?utf-8?B?aXpqcjZVVjJOWmZ6aSt0c0pmbkpEL0ViRXdpVWpEblczUm5ONnU2Yi9HYUhs?=
 =?utf-8?B?Y0hBdjRvY2E1dHFzUS9WZ3E0VFBHTmx0bTFTRythNkZ6R0FiS3JOc3pBcW1L?=
 =?utf-8?B?Y3pjOHdCaEIwUERwUS9nbTdZbXBuN1VaODlvVmlpWTBLY0I2YUdmSG1LQ2Rr?=
 =?utf-8?B?aXEvdVUyRDM1N3RFZyt2TUY4ckxCWS9ZODdqeTVZVG5XSXpYdnhZZFAvN0tW?=
 =?utf-8?B?cHNXaVVuc0dYN3NJSkVxRUtLRGpXRmxVWWQzRUZFMFdVRUgzUFkvVnBpU0J6?=
 =?utf-8?B?QUxDNUZqMVpaOVkxc09vRHUyd2FjbzFoRkxpM2tYLzBzU2RkYTV4S2dpdmxM?=
 =?utf-8?B?c0xDV0c4NmEvZW8wSlVzd0d2S1RRQ0pWNFY4RGd4QlhYc2FsRjFac0pHZUk5?=
 =?utf-8?B?eS9sa3pWZkJ6bWhXbWdtWFl3KzJ6cWQ2eHRPcG5ZZjhDUmZlV2RCcEhkOVJo?=
 =?utf-8?B?M1NWc1FseGpBM2Z4NFpJeTUwa1VjOFFhMVJJSHp5N0UwYldoWUxkTGxCY1RK?=
 =?utf-8?B?dWg0RGExekg4R2NpZ3RwVFdjVDUvMDg2eVdmcEdETVBaV0huMGxudEF0TmdD?=
 =?utf-8?B?U0F3cW43S2c0aFhIMTRWUnBsTlVMNXVnT0EwOFVSV055Q214SjdLNlRQdFFO?=
 =?utf-8?B?ZDc5WHpaK25aVUV0aFBIeWxIeFUwUUwyeG1DVUlCMzVmdC9aWFV6RWg2MGJS?=
 =?utf-8?B?SVFac2tKTVg3d1FTZDUvOStuM0YwOCtYR05hSXZVUDFpNzlyWmhxWUtWUlYv?=
 =?utf-8?B?ZkhVOVl1K0czYWFBRjk5cUNPYkFrWFZZcEhROVVxZlN1YmxsYnVxRURsSHVq?=
 =?utf-8?B?SXVwbTA1MVRVdzlFNlozOTZXWHFHVGlKek1qOGhiclJIZS84b25vYVhURmdY?=
 =?utf-8?B?M3c2cHBiM05yTXRlV3VPWEhKUC9XRjZTZlZ6dHA3Tk5IS3J5MXBGaFQxMUZ1?=
 =?utf-8?B?MkVCK0dGRStrdVRzMENuYnhvUUZPVmFrdGk4SStaRTlGRzcrNWZ6VlFUdExJ?=
 =?utf-8?B?ZGp4M0h2ak1zcktpRU51VWhGa2tHRTM4TXQzbXlwZnMycjJyQzhVUk54bEJG?=
 =?utf-8?B?TzcwOVplRzJSRFZnemltNENqc0JNTFduMDhpaU0raGJ2T0Z6T01td1VuRjk1?=
 =?utf-8?B?L01sbkFYWWNaK2ZDZHBpSVh3Vk5GcHhuK3JCR0RzVExObnZHVUxhM3lqNlUr?=
 =?utf-8?Q?34VUnxiuJBSSJhdnkGafum1Sw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7682df99-3b3e-4db0-11f0-08db180160e8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:57:20.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARn4CAFctIGfqXsmVtArr8VOrIasFAmIjV4PjphaXYCZZR/zLcJnw/bk99HfjEHyRmNU2zforCRI11DueYQUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 26/02/2023 14:53, Leon Romanovsky wrote:
> +Mark
> 
> On Fri, Feb 24, 2023 at 11:14:47AM +0000, huangjunxian (C) wrote:
>> Hi folks!
>>
>> We've been working on LAG in hns RoCE driver, and we notice that when a FAILOVER event
>> occurs in active-backup mode, all GIDs of the RDMA bond device are deleted and new GIDs
>> are added, triggered by the event handler listed below.
>>
>> So, when a FAILOVER event occurs on a RDMA bond device with running traffic, does it make
>> sense that the traffic is terminated since its GIDs are deleted?

Yep, please read the original commit message:

commit 238fdf48f2b54a01cedb5774c3a1e81c94e1a3a0
Author: Matan Barak <matanb@mellanox.com>
Date:   Thu Jul 30 18:33:27 2015 +0300

    IB/core: Add RoCE table bonding support

    Handling bonding and other devices require us to all all GIDs of the
    net-devices which are upper-devices of the RoCE port related
    net-device.

    Active-backup configurations imposes even more challenges as the
    default GID should only be set on the active devices (this is
    necessary as otherwise the same MAC could be used for several
    slaves and thus several slaves will have identical GIDs).

    Managing these configurations are done by listening to:
    (a) NETDEV_CHANGEUPPER event
            (1) if a related net-device is linked, delete all inactive
                slaves default GIDs and add the upper device GIDs.
            (2) if a related net-device is unlinked, delete all upper GIDs
                and add the default GIDs.
    (b) NETDEV_BONDING_FAILOVER:
            (1) delete the bond GIDs from inactive slaves
            (2) delete the inactive slave's default GIDs
            (3) Add the bond GIDs to the active slave.

    Signed-off-by: Matan Barak <matanb@mellanox.com>
    Signed-off-by: Doug Ledford <dledford@redhat.com>

and please read: https://wiki.linuxfoundation.org/networking/bonding
especially the section that explains some of the restrictions of
active-backup mode.

Mark

>>
>> The FAILOVER event handler mentioned above:
>> static int netdevice_event(struct notifier_block *this, unsigned long event, void *ptr)
>> {
>>          ......
>>          static const struct netdev_event_work_cmd bonding_event_ips_del_cmd = {
>>                   .cb = del_netdev_upper_ips, .filter = upper_device_filter};
>>          ......
>>          switch (event) {
>>          ......
>>          case NETDEV_BONDING_FAILOVER:
>>                   cmds[0] = bonding_event_ips_del_cmd;
>>                   /* Add default GIDs of the bond device */
>>                   cmds[1] = bonding_default_add_cmd;
>>                   /* Add IP based GIDs of the bond device */
>>                   cmds[2] = add_cmd_upper_ips;
>>                   break;
>>          ......
>>          }
>>          ......
>> }
>>
>> Thanks,
>> Junxian
