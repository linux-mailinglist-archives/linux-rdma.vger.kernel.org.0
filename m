Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C09C5A21BC
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 09:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbiHZHZN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbiHZHZM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 03:25:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF41A397
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 00:25:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q3IRg4025358;
        Fri, 26 Aug 2022 07:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=BvcHIaqnGKH6uJiy5J7UrFxeGpyM/thKfMZqNcvqWRw=;
 b=Zc1zkhMm+ibxLTBlvhVrlJYCX4yotNMInK5xIcfzOD0Iy6XslKxA6pcgzOH3k51IPuhP
 CTi3FsJUMzwZVmKdK4OoZwI0ASU8o8kGdxrlUWSz1jCxZce5Dkneir3kpY+WRxtye7cm
 hQoy+ZaVPVUk8XG3FIvnblRHeR2DfkCTxY5oD8SN0D9lsVUFA9ajcJLq3VCWXGVMrLeM
 cAewCcVJxtUPvqHF9aT0HVCocuHuwBd7WqN+tRNuI4liN/FBCEnNa5enEj00eZsWtXQq
 dDt/CtR0IePjtUpnRRo1AIS11TTCnFEscn+PJBiqYOHnYFwUUQNO8EIW7DKofBFr+iDO og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w240u88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 07:25:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q46dta017037;
        Fri, 26 Aug 2022 07:25:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5qd7wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 07:25:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSX0npk8YSuzMVLcO7EvimmLVTONF4CeCW1eJMp/5fmi1GjLE8en/TV6eMxA1TLYEtPpsz4kR3vFbzUyztD/yUAfFNMLkOeqpJYvACrIEnrMhpwP44oXbkk94toS5V1zMP1/wKpPY1AJeOrsg6KpDBIK1ReYvJe+7ApcmDq6XDZEQa4i5wN4WGGmhLcMIZh/Ak0UUSpOqEI+c9eJ35ndr58wAr4dEFYusFmzaQxLwZ7cvgMchgb2Y1PxyA6jHGb5n901dx1q4xkSmTWDOdMDOE7zCIldtmkhHxpZ3zuaUKQFweVzslp9+Cx4WswmLOR1uZhJCpfbHf8QB/PimIqoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvcHIaqnGKH6uJiy5J7UrFxeGpyM/thKfMZqNcvqWRw=;
 b=X+Rk3Pga1lJPT/NDWbayToE0DeoGqTBfHIhbH15GwuIv0f8DXAvyOroLp4Iq3OT5J4vN8qRB/QDOWvX0OY03row56J08mhoKajCVVUosu0VdfcDYdfUzGgKJywRRIp7qtMACtNt3pIbJl4y76CNu66NmRwKgRhKHV6r9jkwl6ieGHxLrPVixN7AgA7Hny7BlYkM9yldIFvFNYZ2gFPdb97MYmOc18RrLduyv3BO7cn/77ik6Pd/9v6LspunsAB5lxVAAw3UYK6JS9YoGvMw/1Xc/12is6NhL77ovAj7Z2fCCy1WqRgm1HnMXaXf74uMONpVKnPACNjCp0GMjp7BEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvcHIaqnGKH6uJiy5J7UrFxeGpyM/thKfMZqNcvqWRw=;
 b=Son+f0vCRaptW80IZvGnBTXedUOYi4m0SvLglywWRoAQ0ri7aMqIJuzTyY5lYHKi0iW6uzUREr9KXzpErEfX5+zcQ+IWPBLN1DAablBjvT+t9oJpnFKHXuPOAseQZA1bBbjTyUhPNDipEhw5kS7ScvRvgDPoHg1ffGftIOu/4hE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5217.namprd10.prod.outlook.com
 (2603:10b6:208:327::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 07:25:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 07:25:05 +0000
Date:   Fri, 26 Aug 2022 10:24:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     roid@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: E-Switch, Move send to vport meta rule
 creation
Message-ID: <Ywh1Qe1EH3+B4/ON@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6949d455-5d24-4fc0-23d9-08da873418af
X-MS-TrafficTypeDiagnostic: BLAPR10MB5217:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arLVJzkR4mNHoAJPIMBZflMTa3Pg/oDECVJNh1GoiaV6S6gQkGQyyrdhXTtkyvKqH+AcAmyaOTx2uodYYkHbOp0eeuRPKuHuU4hoOX40dAzqgfUQWR/jshJvRMf3VAibgdHEET//+f5gatW2aZz3eA1ozDjH5YWrLXPQM4Dxm/dEaxWuHJ1/tJW8NKSDSN+z96WSNSdFPQXy6qYo2B11Tl9Db/qAy1ySWK3gUEqAtBo18v8Nd5WWEXdRNxnoqDshhGeFti9BE57x6Adz0+GKeD1wrNcbtIbEdaAkBOb/EX1DGC3qAkXxVHVFrxBmPXXPXmgeElwDd8/YrKDyui+DP4TNNBuQ1zI3ltTMPc1RoEJ5txDaoiwiGb5mmH520KQMpBfnm+UrC1WFsz/jZhdzJhnNrQB6EIjM1qOwL53Ch2q8tubKI5faGYT6iOV8JYu9f7j8RwTSUW/CqJMFDQ7ocMjQDysPabfZKjcz3vG5FVYtfTtQNGgC36XClr1JV/pZPFcssUVBC0eRYcQXBFbtHikQP8rMxTabUZOR8bOAp++SeUNUzI0CjCVM925P88ePtvPjiKwKnHZbuDBWkA/c8zgSKQ4Rsy9UlQiBuuc3DtdHUE1gc0eMg1u501EyQM1KybWYcuOnSQO6zi/V+1oEVjdBSxVoMz2XAb5myvV/qy/EzopthtpRjyzFNRc3xQkrKV0lh//+KhMiGeOKXNHiiWy7mCPPMIbTp9H4VdZAWtx+UT0vf654gmIzWtvDgAngExSXeIty1uccd66OvqmA3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(2906002)(83380400001)(186003)(9686003)(41300700001)(6512007)(52116002)(6666004)(6506007)(478600001)(26005)(44832011)(5660300002)(38350700002)(38100700002)(6486002)(86362001)(8936002)(316002)(6916009)(4326008)(66556008)(66946007)(66476007)(8676002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6R0FA1MkuqM/5v0GvQm0jNbnLaYS03IMTW5SoB8EfO58J0MbZQciH9FtrMy?=
 =?us-ascii?Q?bxHyNQUE0MUObx2UmN+WeA1vZbbBpchdlbs/OgsOOI5AamUPRi9/vR0aTzhi?=
 =?us-ascii?Q?UMTrfghJbtVJAFIe8Ltk8BbYJCbHRCE91mVpdZLNJ64FgRAmqyYT2EzSzav5?=
 =?us-ascii?Q?eUhiQl4fTPkWxu9lBtH8qpYQ9hSVAm55fvg8oLMwAhkVn/zNTgWHvwByo9s2?=
 =?us-ascii?Q?QdwYlTNES29gEe+8e6pnrNHj0u+dNduXMFrsY3HU4yf5AgFjiHsq84GzCYLi?=
 =?us-ascii?Q?IxQVrwpElbTWTQEV8/K6Fl9H5h935YnP4k5NZ5wTrBRuGC0/BikSuo49pK9z?=
 =?us-ascii?Q?xpvTDJh4xxAA6kpFTo8u+hXEUc/7gYFUvjmMIDndY97eamxDpNmXgWHFmde2?=
 =?us-ascii?Q?25NY9PR9DTweSuRWzSKRFFHsJDj0s6AP1sXL65xxxTfWxa5UAl07pnrDjL1/?=
 =?us-ascii?Q?BfRzSsiXo8sC2KlwhBXG6mbPQZmfNjbJW1QqF3ygZtJANyGJ6ZEfUig4xCYS?=
 =?us-ascii?Q?ValTnokpbYIjTQuxhH9VlO7Z+97b1Br4kpmefCLRrdt7LEZtDjCshqR9n91d?=
 =?us-ascii?Q?whGmiftGvbMOhbKzevPnHkAKlD4REteDatdce3d0jFvTc3Q8qQ9+OCUKIoIy?=
 =?us-ascii?Q?ykvixIFXH82mdHDSPFZZbOi2E1HZzMoSD+0k2OxDnkaDOhbZiHI8gFpRqw3F?=
 =?us-ascii?Q?a81rUo+fUeMLb3Y7PRvO3qhmiMdL4KmzzKxviSizoRHpxJE03JRff87YQhcq?=
 =?us-ascii?Q?X8mdtq+XGlNYyF63ZGtu2SSdOPq2C92B5dMS3AiMtuOfMVfi2TlhPnQMoIKU?=
 =?us-ascii?Q?XXQmuqlpwTI2MaUzI/MM+Nz2LoA6gUk7diUXZM30qkutlTbBTNZKSr0wV23C?=
 =?us-ascii?Q?Wc+f2abjbEI326mrum+1h7cF/wW3UzQsTbNT+NZVW3RhmS0AJmmZfCEBdwxP?=
 =?us-ascii?Q?b5O3PMHI/5siq2kjsMIVaAaAcY2gfQrlz6iZDswNrWPXoKDisHKwE8JYJa8b?=
 =?us-ascii?Q?TtT/olOWW56o3gdkNGNVXWBbol2aqMSiI2HZO/cv1eqGM94TVzCmgZG2n4V4?=
 =?us-ascii?Q?vQFB4uPBPo+/kKBBiOuI7Cx6mxVxjoJfAX3MQbH1cuRC9ackkNqXv77H0SG+?=
 =?us-ascii?Q?fLjTuXTCcq1grLhAbwm7DvVIOK0O/QETpSyZeE5hb3l4YrkpKAeSpz4esNAl?=
 =?us-ascii?Q?ia+e+J0M6k1dnP7DxCY97d3hlXgbQUAbKyEnTAhCTyh963RqhsVMl+eX9yAI?=
 =?us-ascii?Q?n0JN/O85KdsVLE8TjtkfhlWcgPA3JyKouEdUYxTB8We+EpvOEVu1QuZMFWDi?=
 =?us-ascii?Q?cRKE4LCT1IUeqU6fWhzJG2Lxwdjjmyoe/tx9QgpJBfWr4mI53UUMrNtYhusM?=
 =?us-ascii?Q?6xGEiHuhxfr3l8PAZIwBfWod5l4+gQbOs1/2P5H/26NvVg2RYYUN9tuOPCNO?=
 =?us-ascii?Q?MS64gKPyYQasz+2bq2bjLuXzkhjhS6LpBfw8IzSlRjUWrgh5RKwhEj4xCkyx?=
 =?us-ascii?Q?yf+eAmF8mTtfNWeNgYjJ2b1v99ePCtoD1Q/3QEltEa4CwfE4MIuFxKrt3Sl7?=
 =?us-ascii?Q?+ejcoYyKB0ka0uDb3tPTq9p2xpfmiVv4oo/+ooVNzwYgldHe7X6s13wfgZjk?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6949d455-5d24-4fc0-23d9-08da873418af
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 07:25:05.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67r7o9RS2mMKS6HZ9+BeSbYeMakV9AbygNT53kmM1OuliXupJajgTlIbmK0xg8ztmwlA6nsWvfjBmc+nOvZ9xPtNFWR8MsgmmbG+D0tXgw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=960
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260026
X-Proofpoint-ORIG-GUID: vysHrbBoPM9cpoHX5nq5ncFMNHWtARh5
X-Proofpoint-GUID: vysHrbBoPM9cpoHX5nq5ncFMNHWtARh5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Roi Dayan,

The patch 430e2d5e2a98: "net/mlx5: E-Switch, Move send to vport meta
rule creation" from Jul 18, 2022, leads to the following Smatch
static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:489 mlx5e_rep_add_meta_tunnel_rule()
	error: uninitialized symbol 'err'.

drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
    466 static int
    467 mlx5e_rep_add_meta_tunnel_rule(struct mlx5e_priv *priv)
    468 {
    469         struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
    470         struct mlx5e_rep_priv *rpriv = priv->ppriv;
    471         struct mlx5_eswitch_rep *rep = rpriv->rep;
    472         struct mlx5_flow_handle *flow_rule;
    473         struct mlx5_flow_group *g;
    474         int err;
    475 
    476         g = esw->fdb_table.offloads.send_to_vport_meta_grp;
    477         if (!g)
    478                 return 0;
    479 
    480         flow_rule = mlx5_eswitch_add_send_to_vport_meta_rule(esw, rep->vport);
    481         if (IS_ERR(flow_rule)) {
    482                 err = PTR_ERR(flow_rule);
    483                 goto out;
    484         }
    485 
    486         rpriv->send_to_vport_meta_rule = flow_rule;
    487 
    488 out:
--> 489         return err;

"err" not initialized on success path.  "goto out;" is 100% suck.
Forgot to set the error code is the canonical bug for do-nothing gotos.

    490 }

regards,
dan carpenter
