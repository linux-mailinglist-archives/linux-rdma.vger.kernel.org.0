Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DBF508F5F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345611AbiDTS3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiDTS3X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 14:29:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FB1EEC9
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 11:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoqK4aRaW+ktBPX/P/KGyRa3ZS/R998vdF5uU+/UtF4VwmiMq/EtbfQa+oF1Q1ZgAUDKJS409K6BnWH0dbHZ/2VqC4oXwDiWXeofmDGwSErwPOxl+g6Tmum1dvQp19mP47jB4ugZ0hmneojiYOAcxEj/98MEh0bMaZl897roAD2tWr6fmdQNQvdLyV9IiO7zrQhgLgOSCXJSLsq5AYNOCk0728JkKzqdMJd63CGrUBMBdegw0dPzm2VPRh7IL5AJ04LxGLyaoQH0ocmypim7bTMMg2KWYL+vM9ySS3w2BB49Euvbpsryvx7jwjWwyjmjLDbBUpNrTpdPeXDvsahN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxHC9a522zrBTQizylX88FjQ+PASaB8EQfsF1kszwWs=;
 b=irlce1mBFrcAUF7NJ/K/nQ8xpPaqxde2EPSMqTfg+lYDbf+tJdohdGP3XnHn9/RvEOyPeBGDjXnIvNUZQvJAMpo/pW7feUx/OdpQUuMia+pfrTVZjZ62ij2mO3VqofVLMzV4lFs5ufYIg7rJgMoURpDJHtmkR9d0O0nz280q3BV4Lo8gRk4Tu3rZzqpUkixaaNfz1V2KVnCJUCga5GL82B4esgnmQnyU923MHQYk/b37a5j0NJzfyWXgYOBSmPPS4nL3DrX6SxaXwA0Dzbhsz8aJRwerjSn7peEtigzRsdTCspftT277PG9vqJ3U6vWzTxZiz3SQ+CPt9iY9X90JOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxHC9a522zrBTQizylX88FjQ+PASaB8EQfsF1kszwWs=;
 b=T7S03Km+Ze2ruHVTwsliOekZB+CR9gLUX4d1N4GhMVLMNCxpkPHDBuWM+6cwXGYjwr80o8obV61rqPl3yB3fKYXQBeAL66V1Ret/uBLG1AWkR7qgiA3+waP8At9VbUXqnFZDZ/fOSV/YXdubb10pVCpFsfNgoxPWhPfAssk/wQ72YSea+idOmsQtkq8yARYySVA8SIuvt4B0AOF+mttNfLNJqMd5IN/VSeWAznfQUAZM79+qhJMExjQxnCqNuwmLdQnRr1aLtpNSvu2e/CVeeUt6yR6Y4t+wWHVDp6KcegecxhHBLMvsxVtSI0E3L7+GURMsVN9EHveoPCCC2M7OAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 18:26:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 18:26:34 +0000
Date:   Wed, 20 Apr 2022 15:26:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc v1] RDMA/cma: Limit join multicast to UD QP type
 only
Message-ID: <20220420182633.GA1478070@nvidia.com>
References: <98466723510491a832171031f591c77e5691979a.1650362467.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98466723510491a832171031f591c77e5691979a.1650362467.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ad9a08-8f9e-4f37-27e7-08da22fb4ca7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4455:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44550C5E46CAA3F645AFBB11C2F59@MN2PR12MB4455.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6CKe99cY3n1VJljyRag5DIy/zI0Ec5F2VYeBUjO+/1GxJkKcz0MVz5V3bcdCOMP/iBsvTFOZ+u7G1YBjqO2ShWx9nckmsMOKD6bOVUYwy6oVdOXLVsJb0xV907e2Q9x9NJCAtcWWeeuCm8LdpPFcviXoD1ipYxkp10VwvxoezL65SAeYj1O45+4eAXIaYhDj1tzJGEtvwauS6pVuSTq+MCKOBQQ750WxZoFWvCrX5UVlQthYpptbPxEMv7SZnnf9UoesP8jaxMSluShKvAyy+iomvuzSLBt3uTlCEZITwgzAlJ002ANUAxOW87huy137r7h24PQvimHeQSgduSNwqhz1ViUVEdua34ONoq2RqEE30X+I8A611v4JABfsLh/7J2yk1uzeX+KuR9cXUxpMSwU2ikm0BNe77+pebaakbSq9BPIKEPm0KZvIK8oDi3yUMlfKKoVm0FN3nKtg2RaXZZJoKroF6cJxpQosTeRxbwZveNRgn1SyywX3Uog4Zz2PnJJPjgZy79blHp3cIUZQv5Ll2ryTIL6JDZ2RMG3aKYM8kwIBd77ulqe1zxkzK/oNIag7j+rCSEGvg32zKMQ+szawTO+QxhUcfaPD2g5JU+/dqxQbpd8aMNOGkXny9I9yB+TEQdk3ZMIGw4Dzw1+xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(38100700002)(66556008)(66476007)(8936002)(86362001)(5660300002)(2906002)(66946007)(508600001)(1076003)(6486002)(186003)(6916009)(2616005)(316002)(36756003)(6506007)(33656002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/gfL602yBsXIe+EeVZAjA5tbPS726QpqEqUyXkGNBhAkdu6/kKALMfguCLP?=
 =?us-ascii?Q?H4Lhl7sURu9ShEimgPS+oXOmFfFwEsNNPJSneFUm6P/zW+2Ug3dNtyF71D3a?=
 =?us-ascii?Q?QVixeVAOdn3L/vg0HGLKykob91WRZaEkEntUuGjXJFm/TsuyyRNgy040x2sG?=
 =?us-ascii?Q?jq9CgDyjDmjzDT6Vtx7s9OiHgMl2H2qSa/OqwKu6KHHc4Q9MEID8EzTJR1sj?=
 =?us-ascii?Q?2Lx7g0EUxpS6Utbo0ECsKZVP4jUw3u3q7KsdflgSDt12vqoFmWhGv/Y94ym4?=
 =?us-ascii?Q?NwcN+cA1HxJx+FyxE5B9m4d75My4BNxREBafxGQzG2ggXQ2GstpTpDUrxHr9?=
 =?us-ascii?Q?QcDvvki4masfeXnyK812VRmmqpTCjDDAa9n9W+W14aMZyUJaaxs17AJA6rbD?=
 =?us-ascii?Q?9/Ayk64LkgUuo6VJgYrHVQFz7kw4kDGWMwm2PAnEZdVkgqZ92DSkAcPDR4cd?=
 =?us-ascii?Q?jWo16nlmc9R0n2lZT8zcOEnHh66vfYEZdID36yJuzOoQ7O6G/khw6XpA3evz?=
 =?us-ascii?Q?p8LEdiRnfZxDIjaV9B5ksf7caybfrWu7rrXRjxkcmVXRdGhSA9+EU8iDM4Xe?=
 =?us-ascii?Q?VFlmUjSpu/s7zVYl4a+O4jlGhmNFraYRn6etOM0UvFqyGfSM68v4605Eccd+?=
 =?us-ascii?Q?jQNTYYrWutnSwEWqcbG2sXMYLF20FAfdDaBELYgRHIJB9D+kfAB+hfH/QgZz?=
 =?us-ascii?Q?snjsCSW2pr2mCtpdgp9tDT8CwichIcVngwXjpuruqMX5+FgQr4Ok2d6H/Ny4?=
 =?us-ascii?Q?fryaYDFpHrovEP/j0SSxsswit3E8rKR+MBiTbNYWrKSQhJ9ucHjYW2+KOcVs?=
 =?us-ascii?Q?1OIdhWO3/ASxeG5A/iblhMogFH5/Ztk3j13kJkRiNApm/DJ7tomj/Y8y74C7?=
 =?us-ascii?Q?oc2xSLZ48MOiw+irrsO7SKWQ4ALnK8uZpehanPB1h5n5fhKHK+IC7d7xcxFL?=
 =?us-ascii?Q?soDtRzKM5cCS4B3Sc6XO9L+3xfl1jV+02ur6MHUskwM2oXBh5CK933t6sPb4?=
 =?us-ascii?Q?UgLm7DWN9zCkDNiGtBOygQ7sTE9sY08d3wT9dvp89GyY1rG0zrAAlEY90Y7Z?=
 =?us-ascii?Q?hcMoYfmTCXzT4w3YisQmgR4466x96YO2RhIA0ktXACoA1/damZHuByDLpXro?=
 =?us-ascii?Q?YukSlJHtDby7WMdJ4eTbM19CDYaZPPzIYLTKZqNy+ecGNxvpPzraTlxVA+YV?=
 =?us-ascii?Q?XFRXqhvbsf5rWDd5cLmdm8LtE7napPB6OkWEuSWDXwi4euyQgs+TV12hJGyL?=
 =?us-ascii?Q?EgfLpusn3KB8AiI/kObxIWOmVusESc9ZZwznUxBsTcxLvAaHach05WYsZ0Li?=
 =?us-ascii?Q?4nSXSRCKSmqjKgm/DxlXJkF5fJ5chzxQViXyOklFShPFXtxCnQ79piS9tdJq?=
 =?us-ascii?Q?6w3elCJuSFfvFqTIJak1n0buPsFeSncvyMMqejRZnk/nVbGM1Voz2EoBCVa/?=
 =?us-ascii?Q?cA1rWCaaixT3HImvpsG4VORWtAz59FHS5CZeBTxvhskBtOA3yk5lqpY4f2CJ?=
 =?us-ascii?Q?z9Il/XZBLt0xx17zFLFw31w5l3O+2U595ZMzg8atU7CRUrEthvrEv3wGMLKZ?=
 =?us-ascii?Q?bFMIGQrSafUnWOkfCbsytBXUCEIVtilwu/mgiKTsvo0wj0qzSxLNmQ240BpA?=
 =?us-ascii?Q?5/NOb5WNl2Sjq6b1UtXTgjij7NykfcWlBDJjsc2e95hjMilQ5duvYi/G4rRO?=
 =?us-ascii?Q?yf5FbDi4wyt2rHJzD09s62xs3GNu6x5D/qw5Qehvw+EJ+UG0hlZ9fxJCOjyD?=
 =?us-ascii?Q?3G2DM8uQaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ad9a08-8f9e-4f37-27e7-08da22fb4ca7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 18:26:34.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFUgIvkHomHNQThxInmsaPTLxHAcp2EN6AljsWlVsuwqws5I78JUeDA0YS6nfR8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 19, 2022 at 01:03:21PM +0300, Leon Romanovsky wrote:


> @@ -528,9 +517,22 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
>  	default:
>  		break;
>  	}
> +
>  	return ret;
>  }
>  
> +static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> +{
> +	if (!qkey)
> +		return cma_set_default_qkey(id_priv);

The point was to get rid of this if since we don't need it once all
the 0 qkey means default cases were split out.

The remaining call sites:

static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
				const struct ib_cm_event *ib_event)
{
		ret = cma_set_qkey(id_priv, rep->qkey);

'rep' is CM_SIDR_REP_Q_KEY and 0 does not mean default in a MAD (0 is
an error)

static void cma_make_mc_event(int status, struct rdma_id_private *id_priv,
			      struct ib_sa_multicast *multicast,
			      struct rdma_cm_event *event,
			      struct cma_multicast *mc)
{
		status = cma_set_qkey(id_priv, be32_to_cpu(multicast->rec.qkey));

Comes from the SA in the IB case (zero is error)

Is wired to ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY); for roce case

static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
			     enum ib_cm_sidr_status status, u32 qkey,
			     const void *private_data, int private_data_len)
{
		ret = cma_set_qkey(id_priv, qkey);


Is rdma_conn_param::qkey, which is only ever set here:

	dst->qkey = (id->route.addr.src_addr.ss_family == AF_IB) ? src->qkey : 0;

Which is the only other place that wants a default set, so I'd prefer
to see the default set open coded here and the normal cma_set_qkey()
return error for 0 qkey.

> @@ -4683,7 +4681,7 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
>  	if (ret)
>  		return ret;
>  
> -	ret = cma_set_qkey(id_priv, 0);
> +	ret = cma_set_default_qkey(id_priv);
>  	if (ret)
>  		return ret;

I'm still not convinced this is right.

I think the flow has the caller do a cma_send_sidr_rep() which will
set a non-default qkey as above, and then do cma_join_ib_multicast
which is supposed to follow the non-default qkey. So this should be
conditional on not already having a set qkey.

> @@ -4762,8 +4760,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>  	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
>  
>  	ib.rec.pkey = cpu_to_be16(0xffff);
> -	if (id_priv->id.ps == RDMA_PS_UDP)
> -		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> +	ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);

And the same logic should apply here, we can't just ignore the qkey
that was set by cma_send_sidr_rep() and program in the UDP_QKEY to the
QP, that would break it. (though that seems like another commit)

Jason
