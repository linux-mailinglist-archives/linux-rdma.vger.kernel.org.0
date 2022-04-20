Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA8508C7F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbiDTP4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346732AbiDTP4D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 11:56:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD7434B6
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 08:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPhE1OrIRtDb4qwOB2WE2sEG9KcJZkm0TFH91+YYHZXcw3runWWNaPfSogb4RPia4YJr6GgncSjAug/A6rwylaH8lcLuIIesl+fS77sqkUM/jgizlMIR+gTxOz6+fGEScF2ofCHGhbDerstJ++5I4UIdEPtNGDWQOzi//vw1MPLouTGceTZadQg7tWN/GqWLyo0awCobDp1lsY31UWe9wleippnwFB29MAxM/wKtpjZmH/dAeUS2MXMXhCO2maPWyptHZsoMHiBEzdjoVBNNzfx8b5u6a7pePM7ZuGnhjvJZHtwNFqOFYUbqB9oeN9zosG0GOh+sxmFmkOWeoYst/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsycO7GNeSmp6+x5M2N/wlrs8h04xRBhOfO2SguOFzo=;
 b=ZXcC4o+LutnVbK7xK5w5NWAY7EAk2AltW47igcoiUUzYkkGZFEkaIYV+GJFw4jF83zfhUhltFdaqxXVvcrI+IRQNswmiz6G8iZ0nK4eT2YcEk4+jsSfIfAoIZR51VwlA4WvOiQiHwL/lg7A0oxL3Luu8osXaVPTdhYpeyu8EAMOT/2qBh6VXeCX+/rT322U2/VN7M6pXChvUFExHKoPTA9KhzWGgChBHQ5Fj57xN0OqfIP3diMHle5TPBbh/705HHd6+6WmmHt8mt30lI3H993soYNQIiqK7h5H47w/7nllpxYEMBCOCGupZ2gWHmJOFsHjyDpYKOgrb2eIltkiXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsycO7GNeSmp6+x5M2N/wlrs8h04xRBhOfO2SguOFzo=;
 b=YcDRODzSbpL3yaxV6a8fP6LK8xCZVqFOqO7pJ2zG7+gL5u6qu60AZzW/HmKJUOiz8gqgZfmvGMUEzrcRS2rovIYUqbKlHR2lei1pKBRVQmaACyDogb1doz5seFP2ECvNxVqbrbZTdqNIPC0S6eS4S7oQNKikm0gGb4+8rRAMp7glWWqflWFXz2pxViKBeuaa9iHg5WATtXjUNUzTaFLvW7iKfku6A+3DiM5EPDJeeUWEcwnuI3Xx1LT3F7NWAIARnVv2uuLa3RPauCi5wocKGyeyPCuM0Xahy4NGV+j7aHZySBKCKnnFyH+xcxBXpfUZgA+izsveDR/2tFhCx4QhuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 15:53:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 15:53:14 +0000
Date:   Wed, 20 Apr 2022 12:53:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in
 responder resources"
Message-ID: <20220420155312.GA1432137@nvidia.com>
References: <20220418174103.3040-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418174103.3040-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b45e25e-061c-4f18-39d0-08da22e5e03d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2846000AD3A9B142E572C43BC2F59@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMJORpko073YDglWXX2NUzsy47E0EEDoWL/o4pxz21A48UH43w8OmPqEEzC+ceGbaNKPXwYdaA8Gsbeup/GTEsEpYekwY2Z1KjLeoUxXPO/zuSgnd8ex4mddh+O7agqwbTP/96iaP++MXskQrXK2kBn4+JXFF50QLaeiA3vHigVEE5Aa8RzAA8rFbMrmrET5f1s4QJ/R4vPLhFqWs6UZuYn6q3LAAspaeBtzmOTOsWkdCxcaK6O5cXTgExgPHVwubpDCpIHxWm6yfXylW6srqPi46NeoSHE/hvK48CReIZSt9J1SzJk/nZUfdWy/hk/EZz6iXcBgygNXN9J0W4sYCbgYJOnpvgCkDNHGi1k7jpYTsKfUaS3rmesBVkyDOIr64TlsnLZcQHjbwcgCQcer81Wb/7IrE5DugKBhcA4LNUxm9l09eYPdt+a46FTMLM4tYPA8pAVp/jPEDaGNcRdMGtI1tiFmi7Vl+xy2RBlBdb3Suq/ZJa5MEYvZkgmInLGslA7bbehIYTnytlZptWHYChdd0D/5krXwuNvunnl4ZlJ6KIaEkPqYibyhO+J/Z/cn5PrzQ61TFDVErSGlafiltWztuYLdzxyGsotvAxzDPC/dVr89kvfeX4PxOyDEc5R5iRNUgWaqVybR9j2i/tV+7orw9zZ47JAPBr5q1J1tvT311Q9Sl8chiEoD8SwPA/WSS4+zzOQdPglVq8wdQ+zBhBnQams9Pg1TnMFry/6nmSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(86362001)(26005)(186003)(1076003)(508600001)(2906002)(6506007)(36756003)(6512007)(4326008)(8676002)(66476007)(8936002)(2616005)(966005)(6916009)(66946007)(33656002)(6486002)(316002)(4744005)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZqoixoIOKPfVHT7OICY4N/OPt4qsJTWQ3CtpCWlcW/SP20dTiPRwXIbTmHT?=
 =?us-ascii?Q?15Dn8ZvOBGLliGNivFmTMOPlzTzEvEv4+aNkXhDzTP9xSYDznmID0cLauPzp?=
 =?us-ascii?Q?FRE5OLYMlOecCLnK6ndNV+Uy+EozNmxelTihcRmoExhN3oUlxK4jdo5res5O?=
 =?us-ascii?Q?uirniwBM+Xkm0FsCw6jiNnbW3ghSXM3ahg5l7RNfBngmYq6++3ploW1Xv0yb?=
 =?us-ascii?Q?q4OW/kwAO5A+DJhHOeWC5lF1PdGjbZ7mKQCcQ3ipyaHuyUCpvIflOJtm4P3u?=
 =?us-ascii?Q?N+ggsnlRfAHhvCXQw01wHlNAtfqGazmUqjppx3spQ1S8grKCGCVO306Qhmwt?=
 =?us-ascii?Q?AjvSXFckBpMfcf5i3C9rh0yxTKFhdLe9do4OkkiIhhTy7wo+rpL3Ii1Xjl/g?=
 =?us-ascii?Q?baGVLnlhJ8CVeSM9mtFLy0eOW7MQk/jagHTRKxqcdMx7+wW+UqSc31v5r/Vf?=
 =?us-ascii?Q?dEqOJZQxJSmYFVdYPrHrT1JSMtxRdPGZnVau8MNg+KM4ZTLBE1KK8iw9IFDJ?=
 =?us-ascii?Q?SQxq8YFV2J6HZd6wSQMk/ajiVFkdutMZEkniFJNFgO0xalbTxvAwHtjBozoQ?=
 =?us-ascii?Q?s4z6YO2rSpd/8rocHhPb659+R7oxozLCgMdwi3g3LZu7ae2eWqea3pV1/l7Z?=
 =?us-ascii?Q?7SrAyNBA66s5mD3+AGqoGwrJL0CrFARIMoq003aiBBDwQxbQZMhrwOkUtyMw?=
 =?us-ascii?Q?T627bFgUM0pg9Pa5uvhvrL5Z/QQtgpaKtGAmryTiEkVsIqt3v9Us4xYburwF?=
 =?us-ascii?Q?7nK40HVSHe4xap4mrPbDExsxIdN91bzPwHy612w4Y6SVkQoizu2Ds6wx2r5i?=
 =?us-ascii?Q?Q0Tahu/ypqDANg3y/S+bvx6RPX+Tswu5rzZJNYxRXxAoiXHftYnZvmW9LUIg?=
 =?us-ascii?Q?SAeC8w9mdRPOt65qfhh9XQol1RKct9EcaJ5q9Y7pt5q8IAWIyxe8wTkUjhc6?=
 =?us-ascii?Q?kAN/2CddIrgFfQB+01jmYczfjitN2LhSNtAbxmknymPsrXspIgjOrMTLLH9K?=
 =?us-ascii?Q?LGYADKCSUcUpQf2YSDclF+ES+jXwal2uP72tC4IUx2DbcmoUnXrsgEFcqIKG?=
 =?us-ascii?Q?e9t03jm8Xseim9L8IsRdO/rcrN11GXih3gE7Movrr5QkAFLfsV8s8iOgj+jH?=
 =?us-ascii?Q?QNqxbzUFXi3106zLZYuqM1yl5V2eJpwA4kN8ItoAnz3+fEawWWWrAXuH9GQZ?=
 =?us-ascii?Q?SrlQgWrowz4f85ITlaUCym0iUChfOwrNRiA7uhSMscdWQCL6ofi3xhznVLVS?=
 =?us-ascii?Q?ebY4XQM1zN4UV/uw6a/1lGllns4+CKw6odxe5YxnL6BoZSW4x2A9MCLwp/Rn?=
 =?us-ascii?Q?6PxcJXGFtHSOyHfBD7JyzM2iYUj06Pdd9U2h3D/qTt1QGcoGj9HkdIVJ7Mbp?=
 =?us-ascii?Q?yhNn0ctd622CUi949vVWYT76RPFBgssjyqaNiMEuhc5eMyU4Or3xkFVEqA1I?=
 =?us-ascii?Q?5rx7gFh9njY3tWjTJFl5weyg06vCC9gJo6FRkOUYwq2iod82jCMsRT1TwTLy?=
 =?us-ascii?Q?nmUJ/8Q/B4x4ZXQPgbqVqezFCF53bwwRtsZpSgYpv4gVqzmj7Pi1NW+H83U0?=
 =?us-ascii?Q?u5GfmfJRd6GukjIll6Zg9I+JsY5UYz2XpN9Y5l6RnUhQPJyLFfGh0NADJh7F?=
 =?us-ascii?Q?T13/ueU+UTe89W5pNas/hNRS8j7nAVLWRqMbqxYhUUHtczOcBIvp4ZzqDfZT?=
 =?us-ascii?Q?aU6djby1uLcNBOvJyrvYHuMT2JIIT7OflzcjqsHzrMHeGRyvv7aZUmeiHEUa?=
 =?us-ascii?Q?h2cJ4IokEA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b45e25e-061c-4f18-39d0-08da22e5e03d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 15:53:14.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtDKPLWBiVdhR7QyS6hzmWh5Luvnk2T0bGLNBT6aYweoDkHlKCWpLPeHTWTzbXGN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 18, 2022 at 12:41:04PM -0500, Bob Pearson wrote:
> The rping benchmark fails on long runs. The root cause of this
> failure has been traced to a failure to compute a nonzero value of mr
> in rare situations.
> 
> Fix this failure by correctly handling the computation of mr in
> read_reply() in rxe_resp.c in the replay flow.
> 
> Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
> Link: https://lore.kernel.org/linux-rdma/1a9a9190-368d-3442-0a62-443b1a6c1209@linux.dev/
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>   Renamed commit
>   Changed fixes line to correctly ID the bug
>   Added a link to the reported mr == NULL issue
> 
>  drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
