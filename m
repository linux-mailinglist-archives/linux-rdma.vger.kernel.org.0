Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D84739035
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 21:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjFUThZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFUThV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 15:37:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2114.outbound.protection.outlook.com [40.107.96.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80871171C;
        Wed, 21 Jun 2023 12:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECEHgkg63KvEdaYchBpTSNjwkR1/Rf/xd8O7t9S8Sz3HHPN050nFposUwCNEW09yeHtgMFGrMY0Tz+ePuNa6Osyfc7DQQ0sGMwej8CuXmKpRkVSqh3JsW2FoMxZiO9ZzORanOrr5BJXlXl7KUa5evWoAZLVQB+zCOvIFBTqZjhdAdVPtx1a8xx4Ohbj7MYHCkTwaUFaB5FyFeFoNrLnDdNLZ9VL2c/MNHBswVaIfzTLvW4IJn4w68snV8y26rDST0L8Km6R0U3cBLPXLEsUfwSZseJNTYWmZwk9PK35k999hP3U6S0Dvh3gzDFtSPS8c5s3fQpZjxlXD1bRMQzRlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv7KCvjy8yxVoEF+arXRQUxHlARgS9e5ZnQhOk04KKk=;
 b=UWd2aVoa+oi121QMQzTyn1fH0crNYJ7jET9VMzekf99mPSEqbnocUR1y70oOIisT4GQzZdTp5sSVMqNJL9eRpBG8A3hX963i5EpvaIbCvx00HrO5lrQNcEFdHWObv3cgOGVOHuSP02PyMWBGy5WKh45KX7jrnmzlDClLJ0F/4oyVizAXH5naQG78MoeseLZY8vIHcEVUTge2fGinFVOUk7XWRCJdJxx7+cvCFrsg6UsaeS9j5SoWRrzOaxqvAL7aQ8tjJlEQIcdDUZ4SYZl3Q5/UdDCQjLcL/6s+nsqox7kre2NwUYtPDtGjnVq1nO8d3wdKHmWA0mEQdA0+ZLj5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv7KCvjy8yxVoEF+arXRQUxHlARgS9e5ZnQhOk04KKk=;
 b=H6SmVNI0iLHKmQYA8Eo2RePGFgjhHDDc0dlJLrcZHgB6yD7lm2dGkTRnU1/BQCtiq/DuwakWUOE8SA3xsq5uvOLXmtJP63TItgh1dpx7zvG5COwqEaKVrnU//c8KS9dNQ66JdoMuLEpU3SccE21zZVpCaAS+tE1b6/IxXmWaBQVMTW9YF2185cxcUprMIv8rZjbw7+AtbQcQ8pjBkDphneCUOexwvBfJzWd6Bv3N4Br6St/gbEg5VFmZUlgPTBSoG5SU/T3OjC7PV1tCkPnh00h2jWR0d6QyJr4UoZAWZE84cH01gfvEvaTLOMWiP1f7uHayuInbD6oO1+kZ2FomvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 SA1PR01MB6687.prod.exchangelabs.com (2603:10b6:806:1a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 19:37:10 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb%6]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:37:10 +0000
Message-ID: <21ba5d93-2717-3b8f-848a-a001cd911695@cornelisnetworks.com>
Date:   Wed, 21 Jun 2023 15:37:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 05/79] qib_fs: switch to new ctime accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-4-jlayton@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230621144735.55953-4-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::10) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|SA1PR01MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: c198dbae-9ea4-46cd-e380-08db728ee786
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHEHclT1gaeLAhKBVpztpHgXvrMkLBJCR+PXv7FWHMmuWLFI6pvwWJF3jyuZiAAbBK/MeSnNN+nBfE6gKY/eRFykN/D2l4UqqXkXK42b1yHiqjH0v69zkUhGwhBUZjVpZrfXCa7uUpLzeOsuudlr1K/mhmsljh6+DlXKHZbn1A+s6RNEpFr/JCrpeTMR4RrvQn06qC15qIhTTTnX22HvhSXjx9J1Xx9JswAPIM1+U9wYHtZ177fATE+0fSA7B/mNf+UKVsaWRuDV8aIia+NG294HgCJ7Mw1N3ip+4oSxuI1qw0EHizrmr49dkv4EWxI8opswcUMuNg7kBPEV/Ls9OyJV80VhUS6hA1S7XbqoD9Vn8QIl7Ms0SHzk1MG19dtF01aQ6oh6OzStH5dPLJxy1fNwA23+v4tHif7+1YqVEsWPNxomsf/WGOvHWKCAILidk7djbFm/hyEYRJAX0jmevEEIw8+CcJnyubDCGlrmVP+lvWYedEQQLS96KZOWw+mnCbrMfEe+p0bey5zIsUNIo3tNn6Ltx9TnHWmOKwjx7LWUxR5LaytySonZMv+vvE6Lkxozqri02Xf5q27C9fh3TNitCoK0ifYJ4g+n4iNbBXjcV9WglgqeFMqtpjaDu1axKFTdiTzoxF8KFEet6yqquw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39840400004)(396003)(136003)(346002)(451199021)(110136005)(478600001)(4326008)(54906003)(26005)(6506007)(6512007)(53546011)(6486002)(186003)(6666004)(52116002)(36756003)(2906002)(8936002)(8676002)(66946007)(41300700001)(66476007)(66556008)(316002)(5660300002)(31696002)(44832011)(38350700002)(83380400001)(31686004)(38100700002)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lMVWxyTXQ5Q2hkdGpPcVNqSXY4dGZSMDJOamNENnpmcjNpdjVaTDdjM2g5?=
 =?utf-8?B?K0huL3BwdE1RckNleGM2aE9XYVN6MXcrakVuL00rZVVhM3V2WCtXZzlzUWN0?=
 =?utf-8?B?dUxxRTFaT0V0NGxOREVONVlGRTUvNzMwRVp4ZUpOQVNtYXowbUtXT0VFbzdG?=
 =?utf-8?B?elhEMHFOTURvVng3VDVWYmZOVDVCRWloNnFEUmNWSmZQT3d6WUhYTUdiMWo5?=
 =?utf-8?B?NTl3Z3VaTjFzSytVak1oVC9pN2VhWlFtS2JVOHVEZjduczRydURrZ3dkdDIz?=
 =?utf-8?B?Y2I2NG55UnlLZkhKM0ZwNVhBT2VXVnZZSnhYSnFXWVc1OVdjRjQ3d3Ixd3lI?=
 =?utf-8?B?UmNiRXlZUTJTMGhTRThWU1RoRlg5WW9UQldwQWwyNWN5UTVzUHJKTnY0d3Zn?=
 =?utf-8?B?YlBOaUVPbGw0aTc4ZzdPTTE4ZHRZUUs2Rk0zbnpTU2V5K2RBSituYXAzQ3BC?=
 =?utf-8?B?VFJkY1hTL2pISGVQMjdRb3NnM0sxbmNEY3d6cVFaTG1sUDlkaHJGSUR2cjMx?=
 =?utf-8?B?d3JMdnE0UFhjeXJzeXl0VXBUUTJWeFBzalVTNWIxamhzaXZkSTJWc0VwaFcr?=
 =?utf-8?B?dHlqM2VEb3NBZFlHaXk3eUtVWCsrVlFMbUJWVXlLU3pxN29XMVZ5OFh0bUZo?=
 =?utf-8?B?aVRSSE9rMEFQKzJHK013bTZrMjNHcFc2dVBHWmhkM1FwQ3VOdHZvOVh6a3VS?=
 =?utf-8?B?bEdJWXp3Z3U2aEJrdDZ3MWpzcnBheklkUTlOM2EzaXBicjBSU0dGcFRQMU9W?=
 =?utf-8?B?SVBhRER6L1lzR0M3UWkva3RmYkVnd09JWTNVVW15TVpJMGpScWVKUmFpcnpz?=
 =?utf-8?B?MU10ZDlqbDRCNXM3NjJXY3M4ZExEM1Voait6aUtNekVKSmNoWVlMN1NPRm1P?=
 =?utf-8?B?VWt6SU9VQS8weFJtcWhDTDEwbzh5Y2FhblRuYW1XdUFWNFIyNERma01WUDZI?=
 =?utf-8?B?YXhxcW8xVFpTbVFXMVMvQ2p1TUNkdlI5d3VOYlk0OWQxWjhVdEJFSmJQSzFK?=
 =?utf-8?B?UUFObmJDVjNqMFdFT3hsYW9BT2UzL2d4VWo0aHZuYk9BQ21zN1BBMjdaL2Z4?=
 =?utf-8?B?UVpVK1pmdjFlQVRjRCtLN3dNcFo0L1dKM2lXZXkwTEtxYUVka1dpUkFPSEpF?=
 =?utf-8?B?bStFRTNvS2N5MWhPWDZ5ZzR6ajhFaWRTYlNsOGR4eitueER6dkFmUm5oMnJY?=
 =?utf-8?B?c1laREJCcG56KzgxUTJkQ0ZmYWdZejFIMTZBZzUybGNteVMxeFVqYnBibUtu?=
 =?utf-8?B?OS9od3A1d3p4TWZqQVNOeWlFS050SnAwRThiRFhvUExKa0ZnRXN1ZXVZeDFy?=
 =?utf-8?B?VENlMlZjZ0FaQnQ1eDNJSmM0RGxzODRmZXhUc0NvRVV2bU5RcFp4bnJzYUpn?=
 =?utf-8?B?YnhuV1pOY0RqTjBTbzFaN1czdFRDN3FsWjR4bDZHSTlaUG5WQjh0QjdaRXYx?=
 =?utf-8?B?MGVQeXNzWWFpdWMvT2hFUFpGYitiNkZtU2tSbVpja1FyS3E0aVVnbklQaFAr?=
 =?utf-8?B?Q2VhUlhRL1lzTTB3eDVDT2hndU1LRmpXSnRPWVAwRXVEckFRdHVXSnVRWkFl?=
 =?utf-8?B?NjBFZ2FWc2cvMitIRk5yRkRqSldwNWZDTG1VSTA4Ny9sVUtzUkR4VllxL0x3?=
 =?utf-8?B?MnRDTTNoeDNXL3k0NlBEL0p5L25OM2Rxb1JPMlpVUEo3eE1MZ0xzU3dGT0Y2?=
 =?utf-8?B?TWhVc1RvT0RSMjg1dHdEM3N4QnlIeTBJY2FNMFd1aHJEK0FLTmlaRU16enY2?=
 =?utf-8?B?aWxHZS9yK0kvckltOUQvaFVzZFRTaytQdGJka2t1MWlLNHJuVnJBcUszNU5H?=
 =?utf-8?B?RDZheFkya3FGT0xhSkhEV1NTRlQvNU9NUWVnQTNRMUVwdXg3b1FRbjFWL0J6?=
 =?utf-8?B?bmZYdWVldnU1TGF0aVhOS0RqR3p3YTFleDczUGdqdGRkcTVpQ3pDSllNWnF0?=
 =?utf-8?B?QXViT1QzTWZ1cmsvazlsamMwTEM4NENMTU50Z1hKaGwweHd2WWJYdys2Qm9L?=
 =?utf-8?B?Q0h5L051TThMM1FSenlYQnRPNzZCcU9QU1FWNkxqc0Y4bE51OTR1eWJVbEdE?=
 =?utf-8?B?bG9xd3dUYTIvT0dsOXVUN252OUF1MWZQT25QT002OFA3TFI2ejBKeWdxMkxV?=
 =?utf-8?B?QkJCditHbnpmZDVKMjdMSHFZWklhNVA4Q1dvdGV1K2RlN2VhTmpjUTdWQUVI?=
 =?utf-8?Q?5+7sgwz5cU4iuEBEFVhBEUU=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c198dbae-9ea4-46cd-e380-08db728ee786
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:37:09.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvvZkIRXz8WwndN4g5/oRRa1jERiMDc222+QMOZqh3koEiEZxwy2o1P0/kFEB8COvhGT9uOch7zVC9Pom6/QqGUEuHMuRZjbvgi00K4u3B1PykJYdJsdDjU9mnWk7u3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6687
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/21/23 10:45 AM, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/infiniband/hw/qib/qib_fs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
> index a973905afd13..db008f2884e4 100644
> --- a/drivers/infiniband/hw/qib/qib_fs.c
> +++ b/drivers/infiniband/hw/qib/qib_fs.c
> @@ -64,9 +64,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
>  	inode->i_uid = GLOBAL_ROOT_UID;
>  	inode->i_gid = GLOBAL_ROOT_GID;
>  	inode->i_blocks = 0;
> -	inode->i_atime = current_time(inode);
> -	inode->i_mtime = inode->i_atime;
> -	inode->i_ctime = inode->i_atime;
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  	inode->i_private = data;
>  	if (S_ISDIR(mode)) {
>  		inode->i_op = &simple_dir_inode_operations;

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
