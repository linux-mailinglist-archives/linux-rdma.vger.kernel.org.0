Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01E68D175
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 09:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBGIaH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 03:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGIaG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 03:30:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562461A94A
        for <linux-rdma@vger.kernel.org>; Tue,  7 Feb 2023 00:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnHI2YdSLOwXOzUORbnVWK05Fr5nchHx7w/66yLpsPaLKBCduKTEJ7akvFbM3MgE56SPwjY7z8CDSCnCCUA8ESxLUJ/yQwOXLnCxSEsPWmBW3+LxNC5oeB6HvB2OnXo3GuGwEvZXBTdhfJy8cYPVvfIdXY7SxbJRmiEBh5pV+TlVbRJw9RVCr7c8EjhsV6cjg5U94rasHfW0ziGsWX9BFV3Kn/3xSTx+8k2W79fc1MDNDw4iFwyNvtlf70zAxK3zO+8hJsdkImfijxjurspgkr619qBa1OaxXOIKzf4kNo8j7QUCqJD+vveR/P/r7e2fwkgH5hIik1ep9UdAT0fBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YVDIQ0K96RAu9ZXJR6RovFeiZ8Pit1u2bVUC7laDgc=;
 b=dadraiIWFAjKZDK+u84LdSEZNumB6CDcxl1Mm0ujoyO5CpWAGdrB+qo4p6T21+VSqDr4tu5B8uRMT997BAtUKxScPr0xrcK7AKApWbsj/70GzxdQ4iS4p6OGpXZ0jrnOpwX/uuUP2tmOPkuamveX9hnX6O+OXQqtmeb6RV7oigvCANG/j3wkX1sdl80bQSNxxa9xLcMfArCbE0a3JHL4UbUnB2hme3D3/e9UVWhxxKQZPoF3JdA0K7uBvFPCrf1e1KDywZNl9j5BeNgSkf1gZBaCY4YiMOJDFE68IKH/jt3zMLRoL1Dtis77k9nkPTqcj5rQvVLHWja66MOdQzFIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YVDIQ0K96RAu9ZXJR6RovFeiZ8Pit1u2bVUC7laDgc=;
 b=LYijZgXAIY+oYrNOkCyXyjFjEJDLfaxBHwSyxz7zCkT85GDOr+4XiKj64Uzj0AP7IgIUCIflMnpor2TFVAR0CHwRbizgK/ilnYFrel9H8tosfu1CWCuqp3CJ6B1g2p6cSaVJK5mN7Pgb3ev8w3kyuGiVk2rw/4GdJcD+cJ00y48pDEqLgX4ig5ecBmmBXtRLTnRhyudISQgxF1zGuiIcIl+kAsNz0TBruED/SjmL1JeXr/5/xT6dmi78P69C+Jukrh+AuXUm3ci1ciz/mQ7ueVVYeyS/EIfFSSwv6FY6SR3Vc7BSB5KTDZ6rT0/BMQrZkmUkjtqgR/vGOxlBmJ5rOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 08:30:03 +0000
Received: from DM4PR12MB5296.namprd12.prod.outlook.com
 ([fe80::47ee:db31:6123:d1ac]) by DM4PR12MB5296.namprd12.prod.outlook.com
 ([fe80::47ee:db31:6123:d1ac%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 08:30:03 +0000
Message-ID: <fd3e4a53-df6d-8e8d-eec1-3f5ec101b4aa@nvidia.com>
Date:   Tue, 7 Feb 2023 10:29:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: ibv_reg_mr hang
To:     yang <wei.xin@enmotech.com>, linux-rdma@vger.kernel.org
References: <8DDFF0AC89400BC0+76d0cfd8-78d8-ba3a-9685-fa1596e5a8c9@enmotech.com>
From:   Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <8DDFF0AC89400BC0+76d0cfd8-78d8-ba3a-9685-fa1596e5a8c9@enmotech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DM4PR12MB5296.namprd12.prod.outlook.com
 (2603:10b6:5:39d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 84304b74-04d5-4c2f-3f6a-08db08e58233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t61rLb07N5mLDN6Kp+cfqIqEGMXlUPBx0Kal//AnviRJ4dlwgo+k8oFXFBgR0XgMUtJ0qfqArVVhYuOcTMVOLXmPj6qmhHGI5WcKa6dVYLEN+RNUGmnrWXqRLReGNwKFTBQb82PNQTQyJWKLm1pIFNoBA2IZwRxAWbn+DcRsi2Km6uw9mRcZjqywvt1mg2UnoXlXkUmGMzV8nx4chIVgab8WM9im6MCgb38sdpD14M3mEb0WlVrv+hoSmLGXG6kp/pZTkdtpLuXzt77gwqUflNfRn9IIObAm5gF0nikq8nPczyWf0he3GdhuPIRrku5krSq9o9H8aadkMi7/OrQX7TKyR/H3GPCfmPOX16swkhlQBP8ScdLBnJ4VOn9UpvzOMpAa4kVejcctgQkbtCLkVlJoAQNUI60WzXOsMsqGEpG0J9YVoso+4+qPG8asteGfvlBQ2jPeZY/6j+bqG17h0LT+6eKurWcCi6PHEn+puZmpYFn4fwkU4TNnpAGH70Ia/kyp92k2VUS8io4dW+O7fC9yzhI9/aG0uFUW++9DkXCvMNnJGKgopsyFd20zi88wzOnwp7sf3eb5XJTbAAYtb8BV2em7FrXIXnyaqWuE07SWAbB2Ela+/QtKGTAkEtLXm/JnjJZrDk+MjVzQ4jWR4HxDyPYvsnxGnEi8A2tfyOe6Poir1A/LdHjoETPJSwBG4rFuZ5zvFwHPphmYEUpF9GoHmouBjKY+5qHCAk9VA28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5296.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199018)(478600001)(66476007)(83380400001)(8676002)(66556008)(66946007)(7116003)(5660300002)(316002)(8936002)(41300700001)(6666004)(6512007)(186003)(6506007)(6486002)(26005)(2616005)(31696002)(36756003)(86362001)(2906002)(4744005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC9GK3hYWEEyV3dtRmZqcUthZ1Y0ZjNuMGZLL1gvbzNiSXN1OTlZMTl5Mm9t?=
 =?utf-8?B?Zmpzc2dDQjZXL0MvcW1uNWF5aGVkUnduTU92bW10STZtUDhhT3k3NlFXRmFi?=
 =?utf-8?B?T0hjZWVMOW1qVTZxRkVzNjVMS29VT2I1RW03OVFJN2tqaVpVcENCcDNOTS9j?=
 =?utf-8?B?ZWx6TmwvMjZpMFB4a0JPOCsreTV6RmRZOWVDWHZyTStUc3ZrS1Q5M3F4dGJB?=
 =?utf-8?B?eXFsTkRsV2dUUW10R0Y0cUQrQk5nakcvTkpkTUExMXRiZzd5eVhIajBGU1JJ?=
 =?utf-8?B?K0Y2R2tQaUNNWXpaQXhLWjg4ZmY2MFQ3SCtaclo1WGozRFFINVlJUWp3VUxT?=
 =?utf-8?B?NG9tcjdOemEwdHU4VU40VUlFN2JBejNGRnp5SHh6a1hHMmN0bjlBTjhFR21F?=
 =?utf-8?B?bGZLTnlORzNxRVdmcFVjdFJ1SUo5TkR2M2dnQjNramphWWZTK3JnekljLzN4?=
 =?utf-8?B?dVlFekhhcDNJOE04SFdhK3lRSVVzakkrYUFWSU1uUEZNSGpicGxEc2wrYlVn?=
 =?utf-8?B?d2trTEU2clVNR0lrNys0VUNvZlpCZmtmY2MvRTVzRCtEays0OXRnZnJlRldj?=
 =?utf-8?B?cWNacm9lSzdxbEZHTEVkVGJPSUJKdGRSeEJNeXlBNzRaTlVWampWd0dvZ2Jo?=
 =?utf-8?B?TW5YUDJKcm16WWU3SW96WFFyTVlhY0sxd0lWUlRMdmlId2FhczRHMU14Wk5W?=
 =?utf-8?B?bkh1V0JLWkxyL0cwNTZ4ZEhUbWh1WWFzOXROTnFUd0c1TEtmblJWWTRpYi84?=
 =?utf-8?B?OU8xZy9aUDd3eTJwUVhCNHlBbDhGOEVZVzFHOHBhQTBXbmtabmJEQ3dqY0tB?=
 =?utf-8?B?cG9qUXRjK28xQlE5Y3hJU3NlV0xFMCt1UGU2cWd5MGpUMVQyM2diYzN5eUZo?=
 =?utf-8?B?cHVsK1k4d05JMk5PTDVVelRMdWJyKzJlTU9xb2FSeXBCTm95bDhUd3UwdjdX?=
 =?utf-8?B?c3N2MUZkOUZZMDU5MFQwc200emJjQlFUZUV6U0tLK0xNZjhKYnZ2WHpUUTN4?=
 =?utf-8?B?NVkvQW1FL1dCekZ6bmlzQmVHbC93QVA4b0xIVnpMbWgvSVRkVlFnc1RRSGFS?=
 =?utf-8?B?dG5VN2k0bm9odkF5MS9uczBpWGVBMXhWQy9yVnhoWlRaSVpmT2dtNFFhTTVH?=
 =?utf-8?B?YVpKWWFjR2Eva251MjdVcUJRZFlsamVJNFNQNllsMy8yRnZmU3JVd3Uxc1ly?=
 =?utf-8?B?cE5sdXRhMy9iV0puYU1vTStUSGlUOXlhaXpQK05uUTNtUXF1SHdEZnBVQmI0?=
 =?utf-8?B?VFJWSTd5SkFtWURLTDhOQkQ4bWRSbXpnTGpJOFJjeEZ1bWtlWnBYTmZiN2RD?=
 =?utf-8?B?ZUF3Q0ZNdXNqV0FJN0VlVXlZN3VoK2NGS05DMVI1K3RERjVjYkNHQjBCSDhJ?=
 =?utf-8?B?clR5cncwc0lOQkRHaDhOSmljZFZMNFJQSkdYcnJjVlRPWFViQlpuYWJhUzRi?=
 =?utf-8?B?dzdyelFSOCtzMUtjL2MxeW8wWVNlWHNiR2RBbEtScnRVRjJ0TUR0eTk2QU0x?=
 =?utf-8?B?Nzg3OVpURG5IWllpYXFCWTJiR3VXeFEwVFFLTVNDaXFZSGlXUWJyUER0T2Yr?=
 =?utf-8?B?YjlSbzRxS3FHS3lJUEx0TGJDWnNnZGo1dXkzY2gxdTh2ZXpoMk1NOFA2bk9q?=
 =?utf-8?B?YmR1UldvZ3VqSzFLODVyQ1NpY3ZTVmZheTJSUGIwUGRiVGFSMlpRWEV6VVNY?=
 =?utf-8?B?cWtTdzd3eERUNm9ZMlArcjFRNzY2anZUeHd1eklSYUtLV3kxeDZ3V3ZMQjdo?=
 =?utf-8?B?UDlxYTNQZ3N3MjVIVHk4bjJOaHFpbXIvaEY0R3VZZDN2SkorRmdVZ3RlYXZ3?=
 =?utf-8?B?TnJsaHlvYXNUNTRpdXk0dTRZb3g4YTdLRDROLy9QSnVFenZNWUdkWWpkZnhV?=
 =?utf-8?B?aUlvZU4ySjN3bDdwR3NYdlZ1ZU1MTDdSOVNZRG43dThCK0hyNlpTQjE1VldJ?=
 =?utf-8?B?SFZQNHNqUFhWdldjbUtZM0Y5Wld6YWlaNzhVZSs0cktRQml6WXkxUHhCN1VS?=
 =?utf-8?B?MEtUZUFJM01nTEFWT1ZDNHh5NzNYVGJRYm1LejV2bGp2UUlqd3ZINy9nWXo3?=
 =?utf-8?B?eTd0M1k1T3ZucGh1dHNvZW8wQk0ySTlxTThmdExpQXA4OWZIUllVdlVOMVJX?=
 =?utf-8?Q?BIi5CoaL5BgdsF+2mF2y8v7IG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84304b74-04d5-4c2f-3f6a-08db08e58233
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5296.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 08:30:03.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNSqMx+gQMr0HNxyvzE5t0H7Zc9Ff2lVwCZF2VOzTIn3Mvn9hF//uUpdzS8ir/4OXUkL7KioD1BYdPE+qP8NdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Yang,

I see it is MLNX_OFED issue.

Please contact official Nvidia support channel.

Thanks,

נכתב על ידי yang, ב־07/02/2023 בשעה 5:09:
> when I test with command `ib_send_bw -D5 -d mlx5_1` it hangs forever, 
> the stack I get from `/proc/pid/stack` is
>
>
> mlx5_ib_post_send_wait+0xce/0x200 [mlx5_ib]
>
> mlx5_ib_update_mr-pas+0x299/0x370 [mlx5_ib]
>
> create_real_mr+0x1a4/0x200 [mlx5_ib]
>
> ib_uverbs_reg_mr+0x17e/0x270 [ib_uverbs]
>
> ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xdd/0x140 [ib_uverbs]
>
> ib_uverbs_run_method+0x229/0x7a0 [ib_uverbs]
>
> ib_uverbs_cmd_verbs.isra.5+0x1a5/0x390 [ib_uverbs]
>
> ib_uverbs_ioctl+0xb8/0x110 [ib_uverbs]
>
> do_vfs_ioctl+0xa4/0x640
>
> ksys_vfs_ioctl+0x70/0x80
>
> do_syscall_64+0x61/0x250
>
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -------------------------------------------------------------------
>
> OS:  openEuler 20.03
>
> Kernel: 4.19.90-2112.8.0.0131.oel
>
> ofed: MLNX_OFED_LINUX-5.7-1.0.2.0
>
>
>
>
