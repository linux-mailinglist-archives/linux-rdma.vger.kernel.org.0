Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E62F2008F6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgFSMtC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 08:49:02 -0400
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:7656
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731131AbgFSMtA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 08:49:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1b9iP3hHSox6mvUsckTnNKhdtwuCWXEynv9VHgyTEeUTyz6/raJYwQI7A4ogOps8L0YGMdlJORTDeopfcq9pxu1Jg91zzWv6CH9PrRRDPOApPHo3L1nDTTHBNWN/LBQS7siMueaPfqFT0/HlDFceosc/I+oPMOw4X2c1rdwCKpTEYf+INADPHrgSc5i58kEFluiPk+GSo747JcMTispzwCXJgNSl8py5xefTWsOjZEAtVZ+6AoP7IhrXb+oQIDAdG/JPexwPwu58tiRJuYI5BUk68nsfC19MbG5kdo/gUO77l8k2UT3HgkxazFcaHykelF/50tA7lh8d4fSNFTd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neAwOoAuJnaoaghnWddHQZHoQHn9GkRKFVo6ShJpp7A=;
 b=Q2akpeILs++f9fJ/jwcidtzOhjt7+F0FUVdqktanrnLDG1FyZfG/lhYx91CpeGW38/Esywu9IdQTUabBd99TLWdUDu+JmmLQEbe/W/A0yTQvSWPk5J9tFlRn0sz2bujom5Bj0W1CpHGc8tkYn7Z64sbk2E1nGpYD5Z1UTSDwE7QHbvAn2hp7iYLG94NhlNS//UyBCjcV2nDE8MOslBdi76r+NAfGNY0JOev2qqm/IEJlRZKfKF+ubVkdf3o2m2lTuIbd5868/nAcsAf6BBqUoasCdvOPaGU4nZc5dCg3e2IgP9uhkThF/lub38mdPtH111i3vCscETbdbuK46gBB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neAwOoAuJnaoaghnWddHQZHoQHn9GkRKFVo6ShJpp7A=;
 b=XR87XJnCrbgEBXUgF9TxU0zBAMGFLDfBp5nSCmYaPatLVmSwqnNMcp2CR2ftY3/2Xc27VC+/1ZM4gQQSi2C/wtt4ryv8QzkrmuS899wZYxY5vSajL8IIIryXa74aRuJ+0WNQQKekYgetWQ1qcOWF4Am9y9NaVSdRyDf0e3jMjVA=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB3262.eurprd05.prod.outlook.com (2603:10a6:802:19::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:48:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 12:48:56 +0000
Date:   Fri, 19 Jun 2020 09:48:52 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, maorg@mellanox.com
Subject: Re: [PATCH rdma-core 07/13] verbs: Introduce
 ibv_import/unimport_pd() verbs
Message-ID: <20200619124852.GV65026@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-8-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592379956-7043-8-git-send-email-yishaih@mellanox.com>
X-ClientProxiedBy: MN2PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:208:120::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:208:120::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:48:56 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jmGRw-00Al5i-HW; Fri, 19 Jun 2020 09:48:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57a50541-06f1-4370-a481-08d8144f20f5
X-MS-TrafficTypeDiagnostic: VI1PR05MB3262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB326278C45786112D83F29A3BCF980@VI1PR05MB3262.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNMbsKFfIUydsIhADK0IqPuDQpRPEJq4EF4pz6k1sIoZjrgULuF1U46UApy3Cp7oqgaknNrijyMlPn3XtdfD+rWSzauiJLBVebOo1l2qMd9TPTMbBLD7bHarikkebSCKVAfytB/ikAiMkTYcpzdbDpUc5fGUymfRGW5SWeicJQwC7GYNCoFDCtfvFg/Cnwo/hP05sbGbsr0T3x/sVwUOl8M43IyMbwuDk67IwU50N8B3qW4SnzbJDGyrNAAkPRNgNTdmjTtzhQz2xfm7zgjfxtCZsWsMOxaYyoZrrXxP3VnCFqmGWk4ITwCVloGht6vN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(316002)(36756003)(2906002)(37006003)(107886003)(5660300002)(4326008)(8936002)(83380400001)(1076003)(86362001)(6862004)(26005)(426003)(6636002)(9786002)(9746002)(2616005)(66556008)(66476007)(33656002)(8676002)(66946007)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hWDnOf19HPC0xO93tBJO9mA5iicl1mVKtVfOlaSkyuf6wBai7D9TLHkooGB01sOGAXoHFXGB5Z+7Oig9drO2l64hqzydNpUok5++n1ibzkk2yozFSPtc8sjqHwzsgy8nvJF41qcEBTmE4f4TC10Ehe40YoFp+G/mMnNvJLSlzU8wJqF2FNgXK/jWfZ7QWevwZg9YneN8G4fAp370a8i67q9h9lpYOWIGfn6okd80fB4Nc+QkkAwyyZew/4SqUEFA7CdXXfm5BZZ6W0JRv6yLBRXTep/AM1WnG+iK8GRq3T2PUJhe9fMm9en7g5yXGknpCX1x+/JV1IkqxZOngszL6xPlW7MSPq/CPpFi5qVot2u0UjwRuBHXf7x+4LIeSGPoKZJYbJ4d+msIogrczAbTzH9tnKoBiFuDDdI6R8hT79SlSOsPRxQk28nh262GGOnPMehfPjfxSwbSJdZ0sQFBWj2QPi47aESFU3C5zdTleO8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a50541-06f1-4370-a481-08d8144f20f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:48:56.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nGYYoz0AkNrM5wTFyC9b8lRoCVNZGyjgmnsH+ZxCZWPgoCwSnBeb/ke78X+g/KXmtULxhH/zfkw0hkcSVJ1mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3262
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 10:45:50AM +0300, Yishai Hadas wrote:
> Introduce ibv_import/unimport_pd() verbs, this enables an application
> who previously imported a device to import a PD from that context and
> use this shared object for its needs.
> 
> A detailed man page as part of this patch describes the expected usage
> and flow.
> 
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>  debian/libibverbs1.symbols        |  2 ++
>  libibverbs/driver.h               |  3 +++
>  libibverbs/dummy_ops.c            | 15 +++++++++++
>  libibverbs/libibverbs.map.in      |  2 ++
>  libibverbs/man/CMakeLists.txt     |  2 ++
>  libibverbs/man/ibv_import_pd.3.md | 57 +++++++++++++++++++++++++++++++++++++++
>  libibverbs/verbs.c                | 14 ++++++++++
>  libibverbs/verbs.h                | 11 ++++++++
>  8 files changed, 106 insertions(+)
>  create mode 100644 libibverbs/man/ibv_import_pd.3.md
> 
> diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
> index e636c1d..ee32bf4 100644
> +++ b/debian/libibverbs1.symbols
> @@ -68,6 +68,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
>   ibv_get_pkey_index@IBVERBS_1.5 20
>   ibv_get_sysfs_path@IBVERBS_1.0 1.1.6
>   ibv_import_device@IBVERBS_1.10 31
> + ibv_import_pd@IBVERBS_1.10 31
>   ibv_init_ah_from_wc@IBVERBS_1.1 1.1.6
>   ibv_modify_qp@IBVERBS_1.0 1.1.6
>   ibv_modify_qp@IBVERBS_1.1 1.1.6
> @@ -102,6 +103,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
>   ibv_resize_cq@IBVERBS_1.0 1.1.6
>   ibv_resize_cq@IBVERBS_1.1 1.1.6
>   ibv_resolve_eth_l2_from_gid@IBVERBS_1.1 1.2.0
> + ibv_unimport_pd@IBVERBS_1.10 31
>   ibv_wc_status_str@IBVERBS_1.1 1.1.6
>   mbps_to_ibv_rate@IBVERBS_1.1 1.1.8
>   mult_to_ibv_rate@IBVERBS_1.0 1.1.6
> diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> index 1883df3..fbf63f3 100644
> +++ b/libibverbs/driver.h
> @@ -311,6 +311,8 @@ struct verbs_context_ops {
>  	void (*free_context)(struct ibv_context *context);
>  	int (*free_dm)(struct ibv_dm *dm);
>  	int (*get_srq_num)(struct ibv_srq *srq, uint32_t *srq_num);
> +	struct ibv_pd *(*import_pd)(struct ibv_context *context,
> +				    uint32_t pd_handle);
>  	int (*modify_cq)(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr);
>  	int (*modify_flow_action_esp)(struct ibv_flow_action *action,
>  				      struct ibv_flow_action_esp_attr *attr);
> @@ -361,6 +363,7 @@ struct verbs_context_ops {
>  	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
>  			void *addr, size_t length, int access);
>  	int (*resize_cq)(struct ibv_cq *cq, int cqe);
> +	void (*unimport_pd)(struct ibv_pd *pd);
>  };
>  
>  static inline struct verbs_device *
> diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
> index 32fec71..9d6d2af 100644
> +++ b/libibverbs/dummy_ops.c
> @@ -287,6 +287,13 @@ static int get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
>  	return EOPNOTSUPP;
>  }
>  
> +static  struct ibv_pd *import_pd(struct ibv_context *context,
> +				 uint32_t pd_handle)

Extra space after static

> +
> +# DESCRIPTION
> +
> +**ibv_import_pd()** returns a protection domain (PD) that is associated with the given
> +*pd_handle* in the given *context*.

Explain how to get pd_handle in the first place, same comment for all
of these man pages

Jason
