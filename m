Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8262069EB36
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Feb 2023 00:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBUX0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Feb 2023 18:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBUX0o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Feb 2023 18:26:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28A330B24
        for <linux-rdma@vger.kernel.org>; Tue, 21 Feb 2023 15:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou7UNrQ7sfRur0EJII5EOIL95PvnCmPsIbDoI981oEiix6Jsbm5Isv2RF37XjkXCGG6cCZEgbFExNMB/qItW+MYVPWeiRTwl9aRSIxGsIn/d64EnM4lY4RgHYeiIIRLdyr+Rc2YbUZxc/CayRioPjzMaIqWXLbFaqMdgJpZO/LHA8SCy3AnRDeCChFhQqHmFLN2zgmtZSpwLSLDTVBjqZmd0AsnCmtAJLGl3QHbFwRspke9DZjdkpLPnPTpYMSwUZR0pk9mEg90mg29FRQmRaHKI9XEfEuDP7l3bRaf1NcjA+z7UuEtlxZT6vsCj05FOArr8QWRI9tDvcEMsbD0o/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npLh36VmUjosLbNyTTB7dSNR9qOH9DVn8ufpHSQ6XQQ=;
 b=jaFug2JOjFd7C3YKwxR4vRC20ub63hIR9fx0wriqY/v1V/LDkN4h7W53IqIuzKxDTbQwTV6jFKyxQaTgBO32b0gAiMuggBq7terqYJGGSTTYgJ/jumiwQDs3W+AZ4FjX9g/LdBegTcS/Sm0PFWMZxVW8qgnXCnO6K4pZ9/oa+4mqchYPS8ow5u98IifpKg6AVnyso5h+6J5/+vF+kP7sIlHgfanW9UEdd6MibkM6pxsfJogK9xsS01az8sODbEo2rcQ1jMdOV6JvPquU79inl3p0FaIibjrxyQk/rH3/fvvwFcs+UWvXr2Zl9uILPFoNg29CPXS71teWXE4XjY8eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npLh36VmUjosLbNyTTB7dSNR9qOH9DVn8ufpHSQ6XQQ=;
 b=HSimh4Dx6+D+b2HqkpS+JE6DeiuGt8tPxANY0QZPupqhh+ahve51UTF+5m7z+BZ2+3S59kdHd3OKoHFxQBnYZla7ptUT2XKVQdIFJk9XATf5uqopgj+noRQdiLwF30ViWBOagTKspq+WXt1oUAK+v4Oevr+s1utjz3EPyo8guanUUl0okMc0sMUCXRnTu/kSRnCmruwEw1+rmKtqq21V976S3OLjujHAXbc3IT7+TxDYKm7S8UR2XsRxDp3egJYW4lyN6moE/uCTJtjPPOH215T7Kby+v4aU7gbCve7xUBT9Tbs0jjlt0S9uGMePyIf9zpeM2gD3N4HDEz918woqIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Tue, 21 Feb
 2023 23:26:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 23:26:40 +0000
Date:   Tue, 21 Feb 2023 19:26:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Remove extra rxe_get(qp) in
 rxe_rcv_mcast_pkt
Message-ID: <Y/VTLrx8ayveJ9/w@nvidia.com>
References: <20230221205428.5052-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221205428.5052-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 6354866b-a64e-40d6-e769-08db14631598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEoQlT8cEhlwsZmXTXaFAa3Kt10bbuwL0PBZ0oe7DVBnVpvmUVCMBwPM27SW4CpAUcsZWmdQUupCTkpqSmu3MlWa9Nn+nDbq63vaPN0WcuTv52mU1J2yyEf8sl4awJgwQc46E4cpAl4nenONyJtVYPxdp/hJ6TzEXaboEX1/S3bAIjON6hWfBNg+n1UI95weiGIpa94PwkU41PtKAlqwGVTiti1ybgMmUZaQ72k0rtkoCJTL7WhslMqbWFkE/GtFkq9G5n/ADroFOvLetA+Hei4gma1h2jUeb5dmy/RM1Tl690HmrtWblLYxCBKXDOe1jRutVFFrhvn8GuDFW7VwdrkhCngQ2eFgo/78RdKVWdyyDX6wXmL5ZfPCJuZ39TvhgPMLpib7Rrx9AqEgOtvvgBYq1AM+CztK/H3i448a15kB347h0BnJ10a5G+s0feena/nwrDFuvn/2vlRZ0Hx9cIPJWrYbUX7zDKF3PwJIVk/uqQAHXE6rRcx5B5Z6881lk5HTOgL0neTR+tDVaY+RIBsx+lUOcl6AU4X+KGMLb6AzhJo/3Iw+rHJQx44hROpChEJCfMdNUU/BIs4Wmvd0SEwwYJ7pQwGzVYu4Ca3kiCtbF74gyRhkYIqKPZQlDWf1qYC5HOmfdZkEUKcx4qlhKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(83380400001)(478600001)(316002)(38100700002)(36756003)(2906002)(86362001)(4326008)(66946007)(6916009)(8936002)(66556008)(66476007)(8676002)(41300700001)(2616005)(186003)(6486002)(6512007)(26005)(6506007)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxKgooMqK6V6hbwybhzI+iQqjsYNqGzfKkSUfHcV1CseQs1xVglGKavResBX?=
 =?us-ascii?Q?lqKAFqBTGYX/ak5ZIHQ82s4RJ2ZAQ2DZN+29BJcsQp88r6NkCDY5K8w892+O?=
 =?us-ascii?Q?XPYD5lfxHR2m3B4pdxpyY4mz70i8RFkWmemR/WYcvMMqrXy0BdDm0HYDOpRW?=
 =?us-ascii?Q?KnB91DZx67pK28vUM6wh6ty51QytiMFUmkvyoujjuqmCHdNcOMCB1UIo/MhR?=
 =?us-ascii?Q?xOmUsUllCGHF/ZyORg0JyLOqyatMTtuFhuywDMhSINZvFNQGMGOzd1Lyn7er?=
 =?us-ascii?Q?WY+i64BBCMoylYUwRLMH/3CL2PnmBv63sy1NV3qpfXG4fxG5RZ6wEpM1p6Qk?=
 =?us-ascii?Q?nM9KQXPtwLGc/wJfLt/BLIzzAsGeuTUKL98mItNaOAQTXk3bb5U0vsxXseYK?=
 =?us-ascii?Q?wUxUgB20iAzBbRrQbjvKNHz3tY7E3teCU8XoLgrvoNdw4M2ZHcyzLEboxTem?=
 =?us-ascii?Q?AJLsLgo0chDOF9av00YLfnfxGOYFX/dNiu47sYBJCRhrAvqxy+DXddaEnOvY?=
 =?us-ascii?Q?b1TD1sMGjSO7oa64CxKeddqeU+WCYzCPQCEsC0onsjzn9TcOFWyJ/HHCcsjK?=
 =?us-ascii?Q?3c42hNr+EsjWG1hPYDwCDOSY+L8Z1XBtZ+/rmCss+qtfgwW1EdOkLjP7lcHU?=
 =?us-ascii?Q?8zFA3dzZu8IZ6w6mYob1cPpJQ2uzBXsNiB17FjwZvB69HwBenBKJH3djA8ng?=
 =?us-ascii?Q?5047YyxSEPqn7yeR90nBWK0aRlD3DCOrP9d3+6Vqk5Ibcpqel+hXt01DEWiB?=
 =?us-ascii?Q?bc5POguh/uSK66/qCiejtndUW7zZAv3ryZfUW9x6P0MzltouOZBTD96z4MmK?=
 =?us-ascii?Q?v8aHA3xITp9a1XFkokbq8NQILvYwQ0jgUEY34EQOqWkOI/bVCnVAMUyXA+B2?=
 =?us-ascii?Q?CC/yZtaPf9tys47B9diBDUecExibGg3jKme2t8Xjnh5w/Uj8472AFNTOxnC6?=
 =?us-ascii?Q?4cVSsIq2xrxWFbJoxOGLEDzZHcaulg+MDqpV+kdB6u6+u389Ryaf41l96rFJ?=
 =?us-ascii?Q?4NSsSNfY7QHTUYvMxXvsm2KFfK0ovPvQFFdT+bv2BzZuzR+OL0Qe/tIt1b07?=
 =?us-ascii?Q?CsHy3q9JIO1+tUNkzRuvdLPgCJg3L9PdwEtS85gzJUcxYt9ZkURF9ekR3Zbl?=
 =?us-ascii?Q?H+NYVEzf9j0HM4M1CLQFtX5pm6ISFnJOFhNC/JhH9ec9dqRIQwjc4la4GGFx?=
 =?us-ascii?Q?M+6Sgj5FiCg0CrEbxvmidri4Kqu+fWNpAu5Hfg9S+TzAxFysXWPtJcdCeQDt?=
 =?us-ascii?Q?HUXpSyUvgkPS7hq+ZYQ3TELQp2pdAdXpoOn/j7I+C+XMnRahBb+Ssv/1aPvc?=
 =?us-ascii?Q?6ndJYUTqIO/9vH/bDCDaTVWBDHzXJbINS+Miqm7gGABW2D7ASV7th1CocJxU?=
 =?us-ascii?Q?tIayOxLcmXZbEWdsLVEKWrJfIgCeAgzHfss8u5HhK9XrQvw/7Ylgex32EwjN?=
 =?us-ascii?Q?IsAqBkcsFneYBRQoqbaVbwjcFKbpPziJ4E7ThxeUAXXz+tEzQoRx+hBwKs34?=
 =?us-ascii?Q?s0Cgmce9culIMsGJmOF/j0umuX6eu/HPga2MSWTRVm7ZahJzSSdpWi7YEd2D?=
 =?us-ascii?Q?GBkCw/9u58KtET5xLm9JPv9xrQSXBc6MXsOFi2od?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354866b-a64e-40d6-e769-08db14631598
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 23:26:40.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPB+Nxi/54QiecHq+ns0K+rJODOFFVl12tIUkRUXgAo90gy0OoJa5nTVWVLXhu6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 21, 2023 at 02:54:29PM -0600, Bob Pearson wrote:
> The rxe driver implements UD multicast support by cloning an incoming
> request packet to give one each to the qp's that belong to the multi-
> cast group. If there are N qp's in the group N-1 clones are created
> and for each one a reference is taken to the ib device and a reference
> is taken to the destination qp. This matches the behavior of non
> multicast packets. The packet itself which already has a reference
> to the ib device and the qp is given to the last qp.
> 
> Incorrectly, rxe_rcv_mcast_pkt() takes an additional qp reference
> which is not needed and will prevent the qp from being destroyed
> without an error timeout. This patch removes that qp reference.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 1 -
>  1 file changed, 1 deletion(-)

Needs a fixes line..

Jason
