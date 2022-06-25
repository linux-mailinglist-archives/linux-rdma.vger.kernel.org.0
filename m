Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8080655A530
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 02:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFYADe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFYADe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 20:03:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F64EF67
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 17:03:33 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ONLrOR005207;
        Sat, 25 Jun 2022 00:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EDhs3sxycBKqXT+sNUwQnz04n7DCUuxQxMt9B+tk/Io=;
 b=u98u++zPNTknQgTiuNtpIm90diROOLBmWd26W8020KEWcx+TO4KrYs7SKUrZDfHrQi2U
 mvbpFvn/Gein8mEMQzTYIFFf1T5GCRyF9qPoZ2/UDjmtqOuDIFIncIypAQQzY96+0fAU
 TSsYHixGx6zmDzyEDrWj7YfVPMA59roY3I5WG0XeCnODe0+izKc+4TKayjMV6A2kDJN+
 klLpitisvxGLQKUbIlnRgdrPDpcixNjMytjzqZ8p37k+C1kL16ylYE16LeFNOX4YC5sP
 W+zUUMb4V48vLHCkjAzabYAVFbfHK/1OiaDGx/fx+t7A3ZkfQNY52ewnNjROPC3C743c Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0q0jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:03:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25P00kTx014756;
        Sat, 25 Jun 2022 00:03:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3ys6ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdHBDSsx6u5uNHIYbnu2mmyTWrYEkAmf96yh4hVGtkPsIudM+MAPBXTrJdg78kwv1NFIAXODDrQMOtDQYMuth6GZwOuSgKYMjS1cBVYYZy6je0jmE/YSJlNAMbmxFWM3ETZ7VnPse3b7TFJoOLJB9oy6gt4vJ6BdQ0k3PZRz9BIKl6US6/qjNcZdiszl3pm0ExxpbY2ZUdt/jgRzOM6Z9snbAeeWgsAPTI28gFmkC0k9qV1yHqymYB2slCzwKhWQBeEOuC3ScG7tvJKKUZlXxHFkjGyCUgsP4CMJtyY0jV9AECh4qbWHKITCAuuBxdezluj+tVyd9wGHx3K1JCgQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDhs3sxycBKqXT+sNUwQnz04n7DCUuxQxMt9B+tk/Io=;
 b=kwU9IE0mhqtPwdSvk3wKtvUdPtMZbLY0ktrxaTx/V/sxlUFHeUvmXYqI0aa//xEMuCv+Bk/W52S2pIWNOhph1cmptKmIFYb3Kj625eDQUPevMoXGVCVacvj3XMku96mcFwF9XZq/EYXOQ0r50KtmZUwsjP4nvdQoKHUaBKXcLO1y1DdJxcjXzHyc7PKThwtVAGODfDTvL+He/k7AQTUgWJJb+52qmjHe40FEF4PqT+rs21CBj6aJDArDkfW0eCLKe9lEgIO/XsgBkuspoO3xxOvyOPm6TkA6uJhj6axK8wFv2jCalO/Qwg++WMNzkzPH+6yU0+A2J8FOJ0v0CJuVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDhs3sxycBKqXT+sNUwQnz04n7DCUuxQxMt9B+tk/Io=;
 b=CODC8GltkRNNlxlRPd2ac88hiy78DIiiuyA1sF9gNw1glDvYkOQf/zeAEPBJBYGPCsI1GbmhS37pBgvSgVV6VItzYQeIBr4LoGm71b0ULWssnwsBktcxi3H6iZAbaqHbRBUCloJNz5ZLu2IvPeLjYqSN06RsAYAWp99I/H5oiko=
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by DM5PR10MB1691.namprd10.prod.outlook.com (2603:10b6:4:3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Sat, 25 Jun 2022 00:03:26 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b%7]) with mapi id 15.20.5353.022; Sat, 25 Jun 2022
 00:03:26 +0000
Message-ID: <101720e727de34c222ac34889b4a75ab6aec4e33.camel@oracle.com>
Subject: Re: [PATCH v2 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
From:   Gerd Rausch <gerd.rausch@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Date:   Fri, 24 Jun 2022 17:03:23 -0700
In-Reply-To: <20220624231134.GE23621@ziepe.ca>
References: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
         <20220624231134.GE23621@ziepe.ca>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:5:40::32) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651ef6b1-268a-4624-2708-08da563e208e
X-MS-TrafficTypeDiagnostic: DM5PR10MB1691:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Petcp78SSTBLedxVGg7MiRObsj9WcMh4uETBeUxRGh5nANk/4cHgw0OfXJ92e966cVfF2nf1g6FuGDXsVGi3LjOgaitFbr3Y5VSXusaZROS90wYMFRmdAY2lo/318Iboc2sb7q+XXy5ch4CFmmqiscigZaUgr+63b1271LxL+ZNF7NXOXb4s/m46SWf2YNwwMCloDwSItuKoKj+tuLTkn1m63EmaN1a/oRAvAWUm3mRIC8f3OV50nZI4Q0JVP4QQ+s21cRCBD8NX8W+gE+JR8ZJm1I1INgESk9cNcul5h664jv85bKqT/xco9t42/6mDgv3iWX44QnACEGZhvsO+/CkigNuOmvBFCUsazGkb2c7vk/EM5sqvnhQxiF+9bY6+oe/63FzWtFi65NfiXfRM9b+93V/6ZWLCxIQhwEpk8Cfn3HIqeBBhBz6Bwt5XD6J+gQW698WO1o2zIT0HTBmTlFCWLgH4M1mjDzJ55oGMKfN57MTQt8QILJza0rf0yivLES4/A+Rdk5oVsRR3u8gKiIbqY6WEpGe1bEBdeA1X0RPvh3wfsuNfjjaiSjJJMSLc0tUqrbrGEMFTV3K818Zd1rMuSz0f4G0ROPBnzMCCJGytDMsuLGJnDqx5d5apUVlq/uSCn5McOtalEZl63/PjGmeMYegMuXfyiuT8Vc1nBjgXyClEvptWiDiywK1VDTlna5V4Hn7Pfvqta2UUWtW8qxNyD1Ut3yZcTZdgdosqnlLDW/M0+CuV5KB3hEyuNldNrwLOQq/87+ZNcmf4NPA/5f7YJd9+WFFFFrquMXYIYSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(39860400002)(366004)(396003)(6916009)(8936002)(6506007)(6666004)(478600001)(316002)(4326008)(6512007)(66946007)(66476007)(52116002)(44832011)(5660300002)(2906002)(6486002)(66556008)(83380400001)(36756003)(2616005)(86362001)(41300700001)(8676002)(38100700002)(186003)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?kkhznhOtAJf5huqCwzNtUlVydyPSTp6NHDBmylghdhl7dLFJGbaUiMUPE?=
 =?iso-8859-15?Q?fhxVQ2jSDnFFzQmVhYFEb3i8Wd8nJmkGyy+wyGFMhRtL/n9JV8uhkAnVP?=
 =?iso-8859-15?Q?Z48TzXJEs9fNTiZwz5fmwuK6Cpo/t63UE7mcUZEl13EAwGrQ64r6kzxgg?=
 =?iso-8859-15?Q?sicaWOG6Fv8AVk/kAb00nWLbLyokuT3WsxFMcm8d/2Hen2gLtjDsMn0yP?=
 =?iso-8859-15?Q?B/B+p+Y7psN4uGdODsPp9PHXeDudnAiXTV2xKIlpl0yop5tDogT6+ELHW?=
 =?iso-8859-15?Q?CimCHg9f4jqin1QeRXNDHkIdmYz4YQaqPQe9O1DK/Otb7507l2bimFrYv?=
 =?iso-8859-15?Q?cl2yS+Igr3w2Y7swgE9mvivc83jxiHs/2tz4Gi7XCWgVRi1sXslL/iDy0?=
 =?iso-8859-15?Q?Cw6kVkJ97/VgK0gnKQ85Cm0tXHJOeVWhGGNdg6qw6vWVFD8cqHnJMkKd9?=
 =?iso-8859-15?Q?ImH3ke3UFe4yVjUsmHZTm1zNr06KJhcHgNkBq7m7X9n4AFbC1EF9EV+oF?=
 =?iso-8859-15?Q?QQ+lRzP2OEyXCzADMhmquBvR8Q15K5oOHTQrMQpHMlPny3zv8RPYeMrck?=
 =?iso-8859-15?Q?8GYJZVnRzbENH7Wz4wh9eWYTxTq4DGNPXzMRgx3O8DbdhTXSyeC2A3dO1?=
 =?iso-8859-15?Q?1/rmNmG5KxQ17D8mbjpQqaP/orOSQb6Next5a07fmsrCajIJE4Xn4a1Mh?=
 =?iso-8859-15?Q?8DSJoXRSK2URj2XQeNGC7DrRONhCJeYya64sW7Y3U5hEjWxR4EZd1+mbq?=
 =?iso-8859-15?Q?aFOGl5/rSS/Bcd17RMIKDPstP/xyz2LfGAOYdu+bZbwJ5Xgu8GK5NlYpK?=
 =?iso-8859-15?Q?8andsr92YFOkrPTOKUcV/jYZ4usSid3xNgG0oXWAt9ZX9wGJkvCMRuLP3?=
 =?iso-8859-15?Q?VQ0OnRT4+EP8SqHKEf1Nk06jnuK1GqS08TOOEeiwyp1ZwAlQHPGjSzzbD?=
 =?iso-8859-15?Q?S+q9sjQGwNqUS/06omqgm4twTh2ACxHGacAZ8eH/VneI4/RxMmQc1mWkb?=
 =?iso-8859-15?Q?tB1uMtWSskCrGCgS6GdLF0L2ZM9c+6LbFPhGRj+34d+9LUgsAKDkp5h3D?=
 =?iso-8859-15?Q?U5T/qkMsyNxSdmAPGg3rYDd+TpTttrzMCFyB4s1NhLnZXXtElLsC26FNc?=
 =?iso-8859-15?Q?VyzHUMHKlYDAXuZQOxFEmyqaXtC7oJ5Xp82JDGE0BbRpXWvpYLnjLpvXk?=
 =?iso-8859-15?Q?dSS1a35hgtygUixQQ1cGX9hHy4fK9Xyz6lZ/UdEFwPzsBnfKmIbNUYsPX?=
 =?iso-8859-15?Q?V2jtdjeYVubyYOSCNPaSTCDnpJBlqKpA5ZMR9Pc29ZZ1XaLj/VNf9G4a5?=
 =?iso-8859-15?Q?8A276N6XM64JzFTY1fdEeLZ3XuTBRybxLCSr69kYkNvA1ymTsX0qClsip?=
 =?iso-8859-15?Q?XYG2FJd6M9Cw3nXl8IG645u9rTdy2oCn42lhUOa7j/Cek5WlYP5VDs659?=
 =?iso-8859-15?Q?Pf469nALbkv5Igyz3EkbeieuT5+IZkgEvUcFyHtzKz7dWrYgZk9+RJWmA?=
 =?iso-8859-15?Q?SmQ+ehbNQOf4Bws3p/NTdZBbOEAhpnLK8Zyii1zWZRYykIz02I6P+DViF?=
 =?iso-8859-15?Q?4iKIs5ORZ1eoq6jE5sqiCGBTQNgURaUhKcE5nLXKNVyvaYlDL2RBQ6jow?=
 =?iso-8859-15?Q?N2z+FNzd3yHvgG7nz6e35Q0B80r883WNNENVd3Z2QGOihTFgLmLSXQ+mr?=
 =?iso-8859-15?Q?ta8MJbgVIYLyf61F8iLUrQPwmpTQ5dH6ql/gRXF8q00Krok=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651ef6b1-268a-4624-2708-08da563e208e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2022 00:03:26.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1vXXVSGy2HxQdtJasP5X58RzoHqNbv6sPC6Behquv4/brRs7zg9R1nUxKTWcDDKDqaNgfayjsFkQ3+Iz8x9Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1691
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_10:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=891
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240092
X-Proofpoint-ORIG-GUID: AVufjFzF6CPH_vXGM5eGEMeAV6Nfbg7D
X-Proofpoint-GUID: AVufjFzF6CPH_vXGM5eGEMeAV6Nfbg7D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Fri, 2022-06-24 at 20:11 -0300, Jason Gunthorpe wrote:
> On Thu, Jun 16, 2022 at 08:57:14AM -0700, Gerd Rausch wrote:
> > Unlike with IPv[46], where "ip_finish_output2" triggers
> > a refresh of STALE neighbour entries via "neigh_output",
> > "rdma_resolve_addr" never triggers an update.
> 
> Why? We alread call neigh_event_send() right after this in
> addr_resolve_neigh(), and this seems to ignore the input resolve_neigh
> to addr_resolve() ?
> 

This in "dst_fetch_ha"?:
--------%<--------%<--------%<--------%<--------%<--------
        if (!(n->nud_state & NUD_VALID)) {
                neigh_event_send(n, NULL);
                ret = -ENODATA;
--------%<--------%<--------%<--------%<--------%<--------

With:
#define NUD_VALID	(NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE|NUD_PROBE
|NUD_STALE|NUD_DELAY)

and the knowledge that the ARP entry is NUD_STALE,
how would that function be called and perform the necessary refresh?


> I think there is more going on here than this commit message is
> explaining.
> 

If the intention of the above mentioned "neigh_event_send" was to
refresh stale entries, then the "if" condition ought to change, no?

Thanks,

  Gerd


