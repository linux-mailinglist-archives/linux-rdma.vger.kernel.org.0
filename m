Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A7351DE19
	for <lists+linux-rdma@lfdr.de>; Fri,  6 May 2022 19:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351020AbiEFRKj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbiEFRKi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 13:10:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D036A076;
        Fri,  6 May 2022 10:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsYNJnergFJEeVJxVcfrGM/n0rSeAORaunQiHEjdykNSwq5gCwnlansOqOYSJWI4NNVukdzxW1FwOBvvQlaW46jNGFJd+5wXPmpe+uBUA+ygICTcEIMkyEzCC2rXe+PQ2IMiTtAH38ZYFHuWBDhoO19RnRlZ47WAZgKzignsVgzbABx/5VE3e0jQe7XfzTuBZX0IQ3gN4dJ3VIQYH+EiSEDvuPZ7/rJzZ82r2rLBmcUYQ45FJvcRzKOOidbkFC8fs+1y9i7JzAtBlBVB/7x/u94iT/L9MaFB461GuJPBhJH4K5DtqCAdKPvTo94lgAXSbrzchURzmzmcbe4sjcg3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJOS87KtLFwZivYb0dt5lBTdgIqE7icDBfC9w9CN15g=;
 b=DrbByASXNCYp4u2O3i3pPEVz3wUt8h47tTiLnTbKG8bUTEhUwKJ4ZBPFtH3YmgNndPtxaOCQIBhUtNXw2Z1Uq9jqdnGhwqXbvnCCdfKk0iGMX/cLG0apEoPBtgtgH0HLuYPgTTq9bSMHk6Ga3YAvh/8BhTFYiGy5m8ns69XyPB3Th+y5fH/rXjtXxbRTOsNE0qkdMPGN15sYHDDvZ08kXaNe+KjqI9pGGm5bLbm2HNCqbfIGV1dE8cYsdBUVoKg/6yw7hr4l6PnKKFhHGfHZsHhbDCcWJNjqB+9VNhOLm8L1h2Wzt7hA2wiH61NoIJ+gcLvAA9pGJXIKhyTnvDmn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJOS87KtLFwZivYb0dt5lBTdgIqE7icDBfC9w9CN15g=;
 b=rjhhgh6SSiOU78NA7h/58DBNKvgSX16XE8sr17dtVlv7pAmr2kBsikZJYTVkf321JkruHOPim/zgkWxegf0ixavbR6XttZaay9GeMTz/23poMuLoDDdAFabGKswiBj73M1xITL/pGLGHx4+cEDWGFJgzCs332yF1OM1/0i564SavFgSrb2QYYndDuFWUGOUgm6RaQhbUH4QMM5FGX2dlejsXMSjr7bpQPdkbfGZwJPAPeG7TBPmH8xgrm+kSp7VxrM6qcHp/KZ61t/HnEFzwDNxlXffRRQr7/oiLUWyzpzZ/zXwRy9SIkh2YKNGEkRJFm6JTUL6HP4EFF2y1FXPVFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3065.namprd12.prod.outlook.com (2603:10b6:5:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 17:06:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 17:06:54 +0000
Date:   Fri, 6 May 2022 14:06:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220506170652.GE49344@nvidia.com>
References: <20220506160151.GA596656@nvidia.com>
 <CAHk-=whZZvzpMHPSWSUWV3tq7VEZW_m-SJqwEDMzYVHdYV_UDA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whZZvzpMHPSWSUWV3tq7VEZW_m-SJqwEDMzYVHdYV_UDA@mail.gmail.com>
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d992b8-77a0-414c-889f-08da2f82d1c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3065:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB306521AC0CF02B5DF48667FAC2C59@DM6PR12MB3065.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+ggGHyaFi7kcUtJys0WyY97+f+zBOrJRgEfwmNfE/ZZQ842V7EEWrrVa36/O0DVsca6l/Qm4czXOTMs+UhJOr3JefdmdKSRQNWHc1zfZcMB7A91gLZPk57OKNR2iFNoiw5iZqDvWGS6kSSfbDpO5IJp008wvov6gO9s0nHHDS0o3RC3AIxDaWbMaO1g4077psRH/TpBMA7DY2RysDvazZ/+BZKPuJCq6nbK6aY9kWrPBpMewxSdUBtU77vtdcOEx3ZzeQ3KL0W8Ophq0W37mBRqejUi4YcmzpnE4eloZnwTdN596Is1CFbyYDoD9iGNOgmp/axjYXN00YV5+hGrws+BVZ+uwhGWEztkskijjb5tsmnXVGwKN/VbWJBqxgQYCgsaizXSRAQrgcrP2G1L7sg2bAi0xYchdiPHKV6DCQNPCfaMUCINXnWko88c6AaWVqWCPQmRPuf26reUdMjIPDZ92yQHU9DUkD6XwIHr0zzffmkz+Ob73z/L9q+jPvanfueMqSCM/tC4piYRepXsc2zB+DJ8Mq7Mg9vC4da83IMI6t9ic+VfpgsroqNvT0m3b17bbjUb+mQw/5GDQXFr41M0xyP/WlmWJgPIsY84jX+zIGzqa+mcc/CEwpzqkeF5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2616005)(5660300002)(6512007)(26005)(186003)(36756003)(1076003)(107886003)(83380400001)(2906002)(53546011)(66476007)(6486002)(6506007)(66556008)(38100700002)(54906003)(6916009)(33656002)(508600001)(8676002)(4326008)(66946007)(4744005)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dW+FOm76wMt/nhUFs9KEmJ6UZsODcBjV6V/ZgNeFCQ/S7E9RMNc3hDB0GZm5?=
 =?us-ascii?Q?zLzKOUFU1L3PuycQjUqZ3Xf/Z9HiRtJb21L33VN8KzX0TkUQwmAyZHOvd6eq?=
 =?us-ascii?Q?Akt3NsbNtaypba0HJOXSUXJrh4Zbtbp4w1eZBwU5zu3dR7s90Y/9174H94bf?=
 =?us-ascii?Q?lQ3Gx09OCN3mIdip75IYZsrdHS8e1hEETffoCa/OFs7QoEXQ2yTs+hok2ax9?=
 =?us-ascii?Q?BzLFykU2kJBHuYEDXMY11G12YiKmo2s02k4JI9eqzNF4nYFBWJIpsYD3M/nV?=
 =?us-ascii?Q?c4xHKqXJ4LREyiZLIjPtFciSxR6PXW7UGJPfI9gixXat9FPVbImKz2Una3MO?=
 =?us-ascii?Q?wD35ttrJxn4Jy3Pdhf12XOLkkEIYTFk4f40grLcdk0Py+4UJA/4gQVGLHzlC?=
 =?us-ascii?Q?eU3GhZyDNnmfuZkfCAtsC/ZUU/geZTvm751b3C605FBlZFFATiTtd0BXrlfD?=
 =?us-ascii?Q?UeH7RH7BTHFInKl3kjWlxV9vAZJC6MBqlxvNSH9OXSkO0SkdctvFdqWyjxEo?=
 =?us-ascii?Q?fQWrpA00dfWRXVx9UGQvw266ayJVqjHnC+jCwKWH2ZDGWGcWfJ9VuBpUaQR3?=
 =?us-ascii?Q?UUbf60mcm4geV/biyI2St9MK6DHBe5CZyF8P5msqHrGyM9AfeKJyeN3vQFuR?=
 =?us-ascii?Q?UMNf8P8az0jCSPLFToHjNch/xZtN3kO0a/fL7ivhqv740LlfMvWgRERuyhkN?=
 =?us-ascii?Q?Oxt7I+11zogId8nJU+5T/R5qLGrF3j/CzYqDCKAOBd+vL9B1i/GYgHd0Mhia?=
 =?us-ascii?Q?+ik9OYjCxiu2ZR8l2NFuNCOrg1EUyAYlzK6TAlddGeIjL6N/R9wwDLu4jY3n?=
 =?us-ascii?Q?W4JI6UThTwp3YMoDI58alu24f8CKNWs2UPQZzl4JZxT+pNDh7avnXudJ4qrI?=
 =?us-ascii?Q?Jf9dlwaZfmiTrZnnOjljMTbMqm4hhnVU5hBhJ8u7UcF73Q/gMbAxpsCTes69?=
 =?us-ascii?Q?r56uD89nNN/IB6n61iAFXdY4H2sTLUTfU1cQ1ZNZmGuxDkcurqYc+lI1YwAG?=
 =?us-ascii?Q?mP8yyBIUx6y7BjgWEXpCln4hwEGM/QZtjTP0AKzX7ZV29ZvmKNCEtvR7Hr1w?=
 =?us-ascii?Q?cg+HnuCj9q/mWuskA3V/dFgSdGdlNPIbfmvQKJqM6OL1s6Mv3M9frFgGV6BO?=
 =?us-ascii?Q?JeMGkbcxqLqUriTV2ku2iVn7Zi3sm0625FI44MhPFmy5+SHUnaofGqixrP10?=
 =?us-ascii?Q?DQCMFHlAzaZtklSeifbkyxdymQDpgcec5IPdo8jhOuqkofWMbYsdQuSgm76m?=
 =?us-ascii?Q?2mfLvlwFyiDPJbg9P7B4mDDRSj182DoaF3JhWPY55CDLl1IGsrcausq0jnul?=
 =?us-ascii?Q?fmKbyKAfy17PYohyH/0GQQZGvvi0AfxEGLovqHZEuSZsYT5EUAOYoChr/I+Z?=
 =?us-ascii?Q?7deLztjEaxNlTSsfj+mK9Im8esN47TH8cXRa43xw6vd1iHd8w8cJ+1uxHENk?=
 =?us-ascii?Q?Cza3zL2flBFPgqgMSbkOgnH96ZhZVi2eUtYr5JDjpglnZbGnEjbJnE4IDZl9?=
 =?us-ascii?Q?ZkGVh9R7R4V2TynusRzEL/LdMMm/sz/Ef46cAcZ0alDeaNJSiUjrDFq/NWnv?=
 =?us-ascii?Q?VtZtJ6jOqtv3OOQdmIYRxoub2gSR/JazqfI9KscJ7p6b0KoAetnWXP1oXCrR?=
 =?us-ascii?Q?qIcaHx/lW7oDWBzSbS3StR8yT1+V675r6Dnz7YRg/VdSPtcAVQuanTZ52r/f?=
 =?us-ascii?Q?99nyx61wGYXeF+bM/tcRD+Yqub1lLScgO2VZVNechkXb0rzAA/Q79z0DkFpg?=
 =?us-ascii?Q?6Vx+0HuQqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d992b8-77a0-414c-889f-08da2f82d1c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 17:06:53.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xW40zfX5vWARpONAbCU4EGPneYc68xTWndSnqb22UgzMVL5akOignSosrIgYYR7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3065
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 06, 2022 at 09:57:07AM -0700, Linus Torvalds wrote:
> On Fri, May 6, 2022 at 9:01 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> >  6 files changed, 92 insertions(+), 103 deletions(-)
> 
> I couldn't for the life of me understand how you got to that diffstat,
> since everything I tried gave me
> 
>  6 files changed, 85 insertions(+), 96 deletions(-)
> 
> instead.
> 
> Until I realized that you must be using the '--histogram' flag to git
> diff. It seems to give quite different results for rxe/rxe_mcast.c.

Huh. That is surprising - I can't say why anymore, but yes this git
tree did have the histrogram setting in the git config.

I took it away

Thanks,
Jason
