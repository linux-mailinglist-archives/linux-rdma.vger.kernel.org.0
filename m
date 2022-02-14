Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F84B58BE
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357166AbiBNRmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 12:42:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357175AbiBNRmH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 12:42:07 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E205652F2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 09:41:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UreDZh9YxL2u3cHAfwf1Fdz8tGx96xvZHYTqkEJA11lt1wdt/JW/JlYQT+r1dzDcddmGQ5+TpRq69qTBQX0ayVZmYGB82IAxpCbZrHC00m8Bo8FsPeMKiSFBQOJIMiFGtr0JJrKlpcV618YD7bnngrMsi77tm7dmpWqlIIZ4THuoF3O8ZCW9GqAhDH1HqA5dlbBwFXA9yr4XtJOu7AKJWW5b5aIZ0YTsnHm9+eIaRwbrpkqFVZQ/TJQrKCctz5aayFe4jJNRTpeRRFGQOskgruw6vjibTnG+bsij8dS21ZwMCzNERgQaYROjRt2YV7XiZJLol6jzC0QQtXoZW/pzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p2fPU1cbt2UwD3xEII6mVBs0lVWQqnccBU8KbWcg54=;
 b=HXaOqspORusJstvnLq8rCd4f/d7IPJUIEpGDXnVKJvInIXDF5DtYV7jNwsi2VzMHZAdahBsCgf5deb8Z5GOvFOOouuWeo3uAPAkw7uCEIylJKO9iDUsQR0C6kW6x7oVbo0dQDQmI+OmmaC+sldMaqAr3cvMe7YvacUBUzgUNOoNMzNfqh+jdlCLC7bDSwZmV/RQ3G74Kyc+4nBGM9rgakSo0irajCBRFYbZX+JiQXiU6uz06A4UNvTuN8qnJBzLGvCUaQTs3DUs2YiCMqVCgwKXgAyS0OgqekhOSj/h1VoxSTOLfs+fWX844LdTUj1IlxdP7Ryj7WDSGCvXqVHyRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p2fPU1cbt2UwD3xEII6mVBs0lVWQqnccBU8KbWcg54=;
 b=Gc5Hfa/ZQfjSGauGNtYpu0zwLzsgXLCBu4rFS5noMxiN7Bw6vv9H+MXAXoBiyxl3GnxYXljK27oILciVaGFTKhpSPFyyf1yeUFvYkhajgBJoSbcc0FcHVVl7mf8uRLAMttJfT0xflW4j/QqalY1rUG+Co5z4ODKjGPG8l8aU/mbbBbTBmhgU1jT38RN+vi+ytncCazDzO9nvqw7C/0EHq6Hbecjk4xN2T6yWEH0pwLIn1ukavsDQUqaVYFC+Sf0rlYpERYkvSlU3yBsPBVoBsD5NUeW+vwWLg/cFkd1TR57/OEmeeNgH4MqB/J4a2nlAUD52w+4gsQ23yj09abRwmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 17:41:58 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 17:41:58 +0000
Date:   Mon, 14 Feb 2022 13:41:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 08/11] RDMA/rxe: Add code to cleanup mcast
 memory
Message-ID: <20220214174157.GH4160@nvidia.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-9-rpearsonhpe@gmail.com>
 <20220211184301.GA576950@nvidia.com>
 <a34545c4-dd47-2613-e08a-cfbc3ce0d32c@gmail.com>
 <20220211195627.GR4160@nvidia.com>
 <0d7916f4-5e53-409d-73d2-d4eadf9c3e0d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7916f4-5e53-409d-73d2-d4eadf9c3e0d@gmail.com>
X-ClientProxiedBy: BL0PR01CA0010.prod.exchangelabs.com (2603:10b6:208:71::23)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f92227c-4781-42a0-76a7-08d9efe14c93
X-MS-TrafficTypeDiagnostic: BL0PR12MB4690:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46908D1782E079F3AB281FA4C2339@BL0PR12MB4690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDrw3f99joKW2WESMjcLbPw3v6PnmznqAIPzCvMCMkacVWTVgn/XQraLtsRJ0uEj/ijNNf/k4mBLI+fUgSYB2gABeKljd//xYK7k37bk6Reg8TNGK0ZI2WnVcBD/nfUq/MUVikO9f4aQGG1ThlsdriqncT/6SsKsIiEU7GQJg91RXvGb4/llwCkjxV/6L6z8eJALOO2ph6+UooTRs64Iw+2fJ4c7AtJeu7g/mF3pVuwBkEVkMmZq9MRxkU3u2rahzUsjmgsmLgTwoZa7fDAPe1SAB6ie+ON02PsmEu9/asEOnHlj0oh38Sax7BlPYc6cHrroM4jcpR2bvXbTel/yE0k2mQ3GmRE6SIyN/a3JVKDkzPR0DJq8O+45iMnU/tLOKys9M9otlpKSLFvF5DuoY2BRdkIlqhA2pf5KDuBRf+VQk3KfL0XHur67+ZCNBhXYpsBeUQXjs0Oy56MQimWVG2QzUeL0yP2PeMmqLTtZrY7AYDG8DAZEcR43aMq2gTrkJZ0vn4v8oz4H5EAyOqR6gdKHRpbIuzOR9yr6a1Vbxj22gON3iqbTFZ2Bf8fojaDpz3JLG7SpZGFTzzAiNq+vZhKtrtrdQVxs/ugXEGHwOuoihL1zF/KoHPf1Wgg47ZIQn/NeKP4EJIbWk/JqHbBEEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(26005)(86362001)(2616005)(186003)(1076003)(6486002)(508600001)(36756003)(6506007)(6512007)(6916009)(8936002)(316002)(4326008)(66476007)(33656002)(5660300002)(2906002)(66946007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9l8NZPzUqDhuT4sepvNZjo887FWXVFGeP2xunxvPXazRFVQZePqoL3R46vXh?=
 =?us-ascii?Q?8scvCwoVxrqWt7uphccG8S0ulRMUPuYZ4aAeRC1E1/xYMi3gQqrrP2r0WcQv?=
 =?us-ascii?Q?mZgZ/d68NbgYxXRtCHIlDZ5KE2lhl8tv+hbXEJQXte5EvzepYj3D8f7IzZp2?=
 =?us-ascii?Q?l9SQZsLxb7EkXO5z020i3MJf/5icpWnC70qlq6xGlpDEZNFRl836qzcHSm3U?=
 =?us-ascii?Q?zlgI+sbfTvQRkWIanNzK+N+HMkViMGkbHeufKUkDswd1KOLPI4n7Sdr8EJen?=
 =?us-ascii?Q?HQI5PpDX6sinvXtKbNMvNqAkWepMu2FEqqjBBBG2/ln1BTH8f2mqxZ51TrAd?=
 =?us-ascii?Q?sHmn36TndX2uresnQ7daxS5jqZHR7Q4l2ExUl1saZazANUOjAumLTLpY32OC?=
 =?us-ascii?Q?c27EtoFrzmPYNXEreesC6ntb0sUCBq1hSnEET1nGJFyieDMxfs0/Gd3mD48m?=
 =?us-ascii?Q?CHFZYFURYl2m/f5mNBW2BXHYaPm1G8Hj8d9xpU8Pi1X4+/jiGrAeR6kCKotH?=
 =?us-ascii?Q?jGR0DHuuBhZqm9atfBXNiyRFez7wi+BLXww5HK2rwYma/A3Fv8DDMre6ZxW/?=
 =?us-ascii?Q?angFl92DaPkk7zvldtf93z5zbazpkfylLx/zy4NSmj7oB4s9K5WdBTShhzp2?=
 =?us-ascii?Q?dBGt2JRejA3oN1tBRM3C3fuzvhfKERRjXlVJFanm8rFM4ESVdpKB+bXoeuC+?=
 =?us-ascii?Q?gbueQ9dLF57Oc+DK348rNm5DYiX3+ETmX1Jocw8EWktBgvORniWjeV7kjM2d?=
 =?us-ascii?Q?WDe0t7kKwA9LiBxC/RTuyzC+cEiTS6+T17OGxDC5e3eAIn1aliwmb1kOoo4W?=
 =?us-ascii?Q?NU4K3zWzqGAxgGw55FhuLDdWkUlLQdQx7jKEZQqd/AKvI1fb5BAcUi22dHf1?=
 =?us-ascii?Q?Co3bKDy7G6gahno6/MSD9l8MnrJj0lDiwGS58EDG0QNeRjIN7V/exUdE0sqY?=
 =?us-ascii?Q?pJiMbPQ5LhRNr9djH+1Elx43thEXOy9OjZpqwPcnk9H8srpqCF+MVfiIiOmw?=
 =?us-ascii?Q?0XyERb2taQEapkUlcA0tkpdH5RjkNuVVb+nDaXENMnC+YoXxZtlE0l+suqWx?=
 =?us-ascii?Q?4lmkTzXx5PWGss2ffBTLkiFqkRs9LNWyEPLxjvVleBcnwdWmo4Xl6eizdNd2?=
 =?us-ascii?Q?+9rAhw+uEPteyCvb0niimZio10w4tbLBkTQOsaT7oZcaMpAscKCM3yAJNl7F?=
 =?us-ascii?Q?7PtNYOx14Nop7e5i8PYRiOSCsVDuItVgZV4banTX/aND6aQdnb02aNuPE+Jw?=
 =?us-ascii?Q?FaIBGuTobB7UBtN0a9x+tvIeVtWs0duiK5nWIbualwsJKJMTUOUQwDKEMe8e?=
 =?us-ascii?Q?O8g9DiXM7vG5dIKKBdPc0xo0VtU2WqNybp/tdRmEy+yRZe3PuigTy0Kxgfns?=
 =?us-ascii?Q?6+eHnzoaTdNf2WVwKEnfNJUtAv6w41Xd+LF1D38ga9ExdnYWR7hlX1SUHxuN?=
 =?us-ascii?Q?WOnA9dDeF0YSjbwOyIq8TfRaQE5tTBWDJrXpbYZ0BDCqbnxg/5mLXvUyeaxF?=
 =?us-ascii?Q?wy3XoJBvdCxyI1rUET6zAbYJxMX/wVHxEvz9qsWb91tUfh0vx56nU12aSa19?=
 =?us-ascii?Q?yG5kCGUDfmRvtfApd0Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f92227c-4781-42a0-76a7-08d9efe14c93
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 17:41:58.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldljkClsJNgsX1Qv2HpZRJLki+mbX7LM8fSRUq1xic+J/kySfqSquVHOuvVTn12j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4690
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 11, 2022 at 06:37:50PM -0600, Bob Pearson wrote:
> > The mcast attachment is affiliated with a QP, when all the QPs are
> > destroyed, which are rdma-core objects, then all attachments should be
> > free'd as well. That should have happened by the time things get here
> > 
> > I would expect a simple WARN_ON that the rb tree is empty in destroy
> > to catch any bugs.
> > 
> > Jason
>
> I wrote a simple user test case that calls ibv_attach_mcast() and
> then sleeps.  If I type ^C the qp is detached as you predicted so
> someone is counting them somewhere. It isn't obvious in rdma-core.

QP destroy is done inside the kernel in all the uverbs stuff, detatch
from multicast during QP destroy should have been inside RXE's qp
destroy function.

> never get called since someone above me is actively cleaning them up
> from failed apps. Or we can just drop this patch and assume it isn't
> needed.

I mean drop this patch and just put a WARN_ON to assert the rb tree is
empty before destroying the memory that holds it, just in case someone
adds a bug someday.

Jason
