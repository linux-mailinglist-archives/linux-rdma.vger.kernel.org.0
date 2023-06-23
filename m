Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FCE73BD84
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFWRMJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFWRMI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 13:12:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3301981
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 10:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMhW7XIp7VJ3IKDzvuVSLwOMsIV/LFZW/ONEeQv3kKrfdJzTtVvT2KaZrU0Jj2ZWHJKTU6MITDxTcM/FdsSPeSrpg6OfqqVPj7SYyjdkbBcfuThPdwdKIiKR/uzGMBmpCiVwNdGNBB/F1K/FJ67SwXUtcsN1w3faDJ3/1IY2zmF56sPBEnlEYUykumx5TiIheYVkzJSr+MvIiYOxyYoe4Ubk1c40gdzazjiG2vUFW+YHRZ8QaeXbqVfem8JkFIUnTwSyIpH7Lcc1WGmJWP0d/hHGvrG3XA38rohM5bJ4nCXM2Mmj0xH4V4RfS2c/bRpkmbUjBnN/4zAfPGfzLua0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EemyRC2+O1nwVFUvFOc11k5icgJkJ72SuYaONC/o1FQ=;
 b=b8BT/8nRryFEBzClUYI30avJHVUtkCvS6FiYelzPPib8tyy8cS08GBIpx5q3H4of3Jkm7IMUIsFbttxSWk7CrNfUYi9ZjIdAXOSNAF9s040J1qP5PuAnjTUUysCDzACGey13oFj37GpClxvW1xjICjoiNU3ORxt2vpn7Dua7W3N1vD4fVIP/hA/F1ZoYCAA26i39DTTa/PUrcEqLId/Wu7jPO9JXr7wfpRpo1pEzvjeMCCa8n0Ta+3Er4B0nfMsNzhPxoWTK7EG2jTpyLEAjx5bZ3/IrnK7rtOHTBCeqoC22ilQpgmYkX5XOJ2uwzGUpV2ZpinJC+IDE7XyjAGy41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EemyRC2+O1nwVFUvFOc11k5icgJkJ72SuYaONC/o1FQ=;
 b=b902+f2pk9kI6drIqAh0Q+W3+8Qb1xtfdJX4qaJ63Y9WXkfcDgfWCCAfmz7aGv4XPOm8yc5KBzK3K6U6CJQNhMAJg/+ZXRcnq1ZUcNt0nL8mnskzf032LJw16w7mZbC+o8JXnVYMmzMWK+zm4DG2up1TdAuAbqt9KKIaPgPbqalym7W6DQRDT3H97wbVwiuVcWOjm6R0UPm0t1Ykm/ovQd17O/tOyuqxfER12YDGF61uv4sbzZ6hwxPH45oZ807PDGEuHX7x25vufDFVP4ytNOGzbUad4VwDWm2TIw9UO7A5sJkxgWRdpO8ZB3JgRlVGY2/JNdjIVoWa1PvrAaXD1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 17:12:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 17:12:05 +0000
Date:   Fri, 23 Jun 2023 14:12:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Tom Talpey <tom@talpey.com>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>
Subject: Re: [PATCH v3 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Message-ID: <ZJXSY8GeA7H04L1U@nvidia.com>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675125998.2279.7297073638926155456.stgit@manet.1015granger.net>
 <ZJRlATrJxBtpMb5L@nvidia.com>
 <F9569E5B-A89B-4683-9A51-CF9C53686358@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9569E5B-A89B-4683-9A51-CF9C53686358@oracle.com>
X-ClientProxiedBy: YT4PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5e1267-c542-4c84-9886-08db740cf7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNc6jfde+rGi1vERxl8CqItZtXNdMccm6QkDLmxX+ReNxcmd82F0KTBPVRtCYXVy+boM8bDiMFlLcOeQYkvEpOy4XaK5Ei5rtdkO49hbbBkD93aHR2Q1qIawU1Ab0oPTOHmicz8AtlWVFgVWmavDPpbdidnqn9l2Ncocb0ScJAT4o4vr8S5GVpiS/CRdwleGN99PwF6DuZNxhFhXpyGnNNrdX838tlTzBjcOGWQTx1NhNlVjmdXnqsgyLFuHoL5XjEIhWChJEVUTw8bNnxNGcQ4VJ1O2s3MjFpWPXLxjH5fN6t9a+3aQdB7c2KDIogP8EWE/1Ferw7SfypLMakbCU5ySQtRzRYiNtM5Uji4KL8Gu97uG0atFwl8YaRS0xiPY3bwOdQNy6FSsrEV3BAHnSDSaDSm5cqsAearLf7y3G8zarxC+R2IakvtAbRddTfZ7kP/+UV/1znKxXZWhSPiPu1nGel+sJF2ezKfzX3euUE0kbfemGePvK5Z5mtFBmLBqnuUo1rtyxVk3DyTmxxbHMJ0Ol6gR/oknl3B0QaMY24xRM+JP9v8eDv/4f9oeysHqotzy2hATAJu8j/ATTu/K8oG4BhguLOOrHLZBcy4i1vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(54906003)(478600001)(26005)(53546011)(6512007)(186003)(6506007)(6486002)(5660300002)(2906002)(36756003)(66946007)(6916009)(4326008)(86362001)(8676002)(41300700001)(66476007)(8936002)(66556008)(316002)(83380400001)(38100700002)(2616005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1PkK8pmjcKlpHqBKDFX0YWBRVnuhenhYfYobBcdYYrznpyh1rDl2Lsh0Cay0?=
 =?us-ascii?Q?oc8GFtHEl+yc7M9jk2oa9q7sY/ggQWhXPGxGszixasXtPfzbbwHDmSbjhWuB?=
 =?us-ascii?Q?3x7QmT7Nq/Koju3+Na3ScBNvtk5e5usrh9i3s/DhWqGluVgX/gErm8xpgXEE?=
 =?us-ascii?Q?BG/SIInJsRDmFK+CyhIEAycaSQOTPW04pUFi6YgWQOjpjRMg2BNU6vQbiSX7?=
 =?us-ascii?Q?HM+T1KEEGeWuxUJms7T1YnJKRL9mwazaTR0d+BNpVYxMTauUzn5NCuybBlF5?=
 =?us-ascii?Q?6jPdQU8zE5nGRN22tJmiUS6cD4Yye6VSEfJVNfsjs4i2MtEZGN/m+FgUFamt?=
 =?us-ascii?Q?CBx6ruUx3oVy/AhZ7TwOICu90uAm5PcaSTmrCOFIU9tGJPXq0L+V9ZpYJ+IG?=
 =?us-ascii?Q?Fdy+i6yxib5EuBwFw4B8OTbCI+l36mrLwEvaGIL0zlyvl6zX5Sc6ldi2MWJE?=
 =?us-ascii?Q?eXA2Zp8E1Ph47ZsV+V8OL69z2rSbr2RZEecoS7jldc/+0csTvpHQUM2x6Cqp?=
 =?us-ascii?Q?JKPSlRh+4lxbgA9bBmKddKG9jyS+igZ2Cz5fiQq+hefsTvgFxnD5/Cxvnhz2?=
 =?us-ascii?Q?tcDJb202L7YWclYu9thjTASC1ZaPNrmNo/eYoT57sFUUFNQiEcjACQrAAPTQ?=
 =?us-ascii?Q?+hGtm8cBNuSoTVK+6nBwQZ/Ak+2MBchWIogwHmdZw/FpRVdvGLhr8gWchdzZ?=
 =?us-ascii?Q?4XjUPb3xEAZalxA9YA1EApXFNDzv9J71p2zF1SNe2Ef4nOT7hL+A66Bc40x6?=
 =?us-ascii?Q?ryHGaluZSZdzVu2D3z6HoeJrPnGdwfj6d1g9+2TezHtir2t8fPZtJIbk37KZ?=
 =?us-ascii?Q?TplB1yH9wyiOuWJnwt80v5WHZZvzJmYDFB7WuBRbXtKiAu7o2lbyQE9pOEmk?=
 =?us-ascii?Q?l63tPK47jU2Is7xKNyBvtTxxZclIQDNSJVkwQaOJv2C5zbz4vK2r8ZjiGZYS?=
 =?us-ascii?Q?HiRDJh8Vb6/UcD7PQB4qb6b3c2iKkQXW+8va22dOznTz5FlT7RDxbtrCTiyk?=
 =?us-ascii?Q?q7EZDHfxfQrTdaMpsQhrLE1XSHuaV0UAUn5sIfQ2HY0Vhwnh4F1ppDk9cbYg?=
 =?us-ascii?Q?QrcZzrTVYsxKkWGuLL6Z8ddDqZ5SPHwCzidbB5gLuLSS/tXfoJRCj6gNHRGW?=
 =?us-ascii?Q?T3ks7iwXllMaF5vRbIy2/86fmRhoKN7zbQu/YN+wgbYki+6csvizp+CL4LEN?=
 =?us-ascii?Q?il/fUUxSdWi2JeKMTHDOeml2tqfxkouJHIX3uipBlmJxMJRt/qJcMV7xc9R3?=
 =?us-ascii?Q?lSDrrGIQxj+jmE/+a43yFkz1LB8s4HXP55rNlcBeVou1vz6AOppRvuBNwiXJ?=
 =?us-ascii?Q?KyAj0eHfmMaDzJ+Y8ZOq1ra6wZBP2Yqv/Cv0J15DNoSfV0nsx4wiT/canb6t?=
 =?us-ascii?Q?8qCxYA5+PpRukuS9yDT7mSaJnSxHZP3E73DfnHVFTe7Uk0vc7ScIi+fT4W1f?=
 =?us-ascii?Q?zTLelxRWll3McWkEHoe6HtrDcuOBUQWhs1Bncdm9+jkn31v6pFoY51H8Q/Pn?=
 =?us-ascii?Q?jXwH6G+OCiIYZRI8D+9Iufam8INyUC2JStfRlRro6zWiXnB6k7KBVIGsy/w+?=
 =?us-ascii?Q?a327ZPvafvTAz6Ibq3apC/XsZXgYOB2u8VgAfHr2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5e1267-c542-4c84-9886-08db740cf7ee
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 17:12:05.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GwRpwYCeUtNyT7ehNPLWumPDc0x5yGpMbulDq23bDGlfbDuv/7k8wtJMd7mjoMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 23, 2023 at 05:02:23PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 22, 2023, at 11:13 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Wed, Jun 14, 2023 at 10:00:59AM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> We would like to enable the use of siw on top of a VPN that is
> >> constructed and managed via a tun device. That hasn't worked up
> >> until now because ARPHRD_NONE devices (such as tun devices) have
> >> no GID for the RDMA/core to look up.
> >> 
> >> But it turns out that the egress device has already been picked for
> >> us -- no GID is necessary. addr_handler() just has to do the right
> >> thing with it.
> >> 
> >> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> drivers/infiniband/core/cma.c |   13 +++++++++++++
> >> 1 file changed, 13 insertions(+)
> >> 
> >> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> >> index a1756ed1faa1..50b8da2c4720 100644
> >> --- a/drivers/infiniband/core/cma.c
> >> +++ b/drivers/infiniband/core/cma.c
> >> @@ -700,6 +700,19 @@ cma_validate_port(struct ib_device *device, u32 port,
> >> if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
> >> goto out;
> >> 
> >> + if (rdma_protocol_iwarp(device, port)) {
> >> + sgid_attr = rdma_get_gid_attr(device, port, 0);
> >> + if (IS_ERR(sgid_attr))
> >> + goto out;
> >> +
> >> + /* XXX: I don't think this is RCU-safe, but does it need to be? */
> > 
> > Maybe for subtle reasons related to iwarp it is safe, but it should
> > make a lockdep splat since you are not holding rcu?
> > 
> > Remove the comment and do a rcu_lock/unlock around this and the deref
> 
> Done, v4 posted.
> 
> The reason I was unsure:
> 
>   CC      drivers/infiniband/core/roce_gid_mgmt.o
>   CHECK   /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:292:23: warning: incorrect type in assignment (different address spaces)
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:292:23:    expected struct net_device [noderef] __rcu *[addressable] ndev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:292:23:    got struct net_device *ndev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:386:48: warning: incorrect type in initializer (different address spaces)
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:386:48:    expected struct net_device [noderef] __rcu *ndev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:386:48:    got struct net_device *ndev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:811:48: warning: incorrect type in argument 2 (different address spaces)
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:811:48:    expected void *filter_cookie
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:811:48:    got struct net_device [noderef] __rcu *ndev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:814:31: warning: incorrect type in argument 1 (different address spaces)
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:814:31:    expected struct net_device *dev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:814:31:    got struct net_device [noderef] __rcu *ndev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:851:31: warning: incorrect type in assignment (different address spaces)
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:851:31:    expected struct net_device [noderef] __rcu *ndev
> /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:851:31:    got struct net_device *ndev

Ah, nobody has cleaned that stuff :\

Jason
