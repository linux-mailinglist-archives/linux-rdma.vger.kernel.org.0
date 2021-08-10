Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0383E56A6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhHJJUM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Aug 2021 05:20:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6358 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238874AbhHJJTU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Aug 2021 05:19:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A9CgRP028789;
        Tue, 10 Aug 2021 09:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=DWfkovp2CJBb+QHt1u9f04rprTQfL5dJgOmzKzF5+TM=;
 b=1KXvWL3A5B4cGKNjZLWEN/g26fVrPPkdzgpn2WPHKjFpD9VlIoc+CNd7N0ludhw/IagE
 PGGfW7xFEYymdKmLcddv1EVcoJeCeEsCoSBZFPatRhbNbtdQQlMa9vprhm8rZyQI5Aab
 /OrgLIOnFjTd9FnwsuS7+uq9jdkglliBGNKcXMJHcUWMebfl6YOxYQhQwVJpq7mAYvhl
 H3UG+X5Nhr/ex8SvYj+5LZ/kIHfpdJDodKfSYA1BIAi99NoYAKT/G+zltGcPo3uxHPSf
 TieuOUVCjJTr5QW/73ZZQV+9J094PEKAv9PBhCB7XPbSuUAr6pPTfF08WymzKXghR4y/ 1A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=DWfkovp2CJBb+QHt1u9f04rprTQfL5dJgOmzKzF5+TM=;
 b=mhS7GhSSrImg5fvfZrzKm4PsN9vfptiM5vYuePosuC2gzbFNjGrujiNRlISKR7RhIfUs
 o5rdnQoAxVZiWgBYRsbELZmu59W9j2XPGkNq9yl0+DGmo5bnTUcDn8oa8Djau5GKXlZk
 zaGqRhDqRYVgt/W3V+HpIPBX66lRfk9vJo6pmPj2523JsVJ6K8JAhdPY3TF1lLxnyf4G
 gzqCFh7AOG0VI5wAdvhgsxfF5CCnsydLN/uQ4PQ/eF9uA7LDydJjbtFbtMQIp+sAjvay
 GAGuLnr3lCxFVd0mrBHDVcinkyZ2gE8kfNsvQBoIZO7wajLg4BXfhGauHjVl8350gTyX qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01rb2wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 09:18:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A9ANpE021147;
        Tue, 10 Aug 2021 09:18:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3a9vv4ctcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 09:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUDcAV2i+w3sJa15hue9CYJuhVCxAIArWWBGwEdXX1oZqDPsXZbz/GXBdNI1PNYBH+RhrftFCFWFL8Zrmy0QLhkblCIZh7LX2N9c/rFAIhP6FeimqEl8zQRhU2mZeGa4LO22mLIZFBZ3klvfIqziTvxjLP4gv8V+8czAkqHGh5If1s5eivafS/pRt3uW50n9mDCv4zmOQXUvmdgXDmYK+2rGu6CkARSD9s6zPAPIX+BxLfEkk1h6Kty7ercIzuCNipY60kzgZhkwuDfJAjogGmuC/1M3KZ49O/tbUHyxFNohjvrCXqpn5QzqqszMPT2vvcPIniDxGukNZUgIfhdqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWfkovp2CJBb+QHt1u9f04rprTQfL5dJgOmzKzF5+TM=;
 b=jW1Ugu+EX9euDPFHuOEIZHNIuNgzwxH9z5BEh465chRGQrDkkjxZfEbedKU2OWR1Pz+JLXNiYv0kJLJEp9H+zpVOOYK8M16I4yI9cOhjJnhmrAc8oDPZ2+BMxyO5blMuRu7OQ1VRqN/0RE+epeLBp4uWW6A4EEozBk1K29+9ehJzRpwmYLgtVjqZXimE/ehQ7FX171qXHFXeXyuPOulQXaTbm766uEHwTIBGXRNbSs681YYGdyv9qkUCKuwAwlQovj5wfXoS1XzUnQYLYbtgwvMrqqLKY/wBQKCeBiwoK6gvpTdfUxoIBAAXX58vKfFJe0qRqfDXRYwvCrTla/FSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWfkovp2CJBb+QHt1u9f04rprTQfL5dJgOmzKzF5+TM=;
 b=d2xy8Kn7UibVj8/jixyd5e08u7bM8O0FXlUnCv2GgQORc37BhtNsVg+14kR0tvhjOnaW1kNWoesy/YXzflsdMGKwKVOakAqV9nmll3Qu61E3RgeCzlSc5j2l1wJnPtf0A1dJedGu7jIBQj9qSwVKMprcF9p5GWiUimFSSR3LRvM=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2320.namprd10.prod.outlook.com
 (2603:10b6:301:2e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Tue, 10 Aug
 2021 09:18:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 09:18:55 +0000
Date:   Tue, 10 Aug 2021 12:18:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/devices: Re-organize device.c locking
Message-ID: <20210810085252.GC23998@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 09:18:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2376c81-2ace-4e14-9129-08d95bdfe06c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB232000A0635D8E637B43DA698EF79@MWHPR1001MB2320.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhaJnS+meOCp073BOsqYWE0lVN++MMsMo6p8hcdMicCUq3BqiwE+rq25ReT3f90NDh+6O6aZdBFbndNqbWRTRZlQfdx5l69bseM+Rj/fgtBvPGmHBrNGK+2hrNqCr8ID8yi5vDPi8HAlIWl5gZFJzc35sgoqHT2e5MN1LyWNtvpgYhy1PGj+Ckqfg3heY9eLK7mfR4QHl5shtrwftEg0/fDgxh97dvPDq4r/MHnd9Nux5xFZ6Ec4R42MpQ45tT/Buvkb/RFh2MK/Er713qOhrhb0jpvZY5wKPOkve9YebORD62gV9K42uYPQB/6+O/Ge5CKbfrznce7Fuy9SPFkiAlV+XJRbl690U8wuYU5cTZoFZyCyEmv0TidoVAss8MDZaF9g8XLj7+jsJVB6xdVvShOoHU+KluTuIgexxH+IG6t9LDXMdKI6sNLKobjVtxjU0W8l7EwkuKWcA8cYX6WyI+X1f7H2pKyGe3Hqx2a4STeBfdgg+jJlA3yt/jmshB5DI211EeDr1SywNJfncLP2eyVZ6Vo1R0U2l5KV1d8HSOdx3uG6tvyhVfs9q6cY/CnNnC7XIfr2Pk7amLRQzw+ribX5XvgataQqNI/d/hbmaXtlaTy2ecI8TKzW5HUBScZxCUhMbwf5BUE4bw0SWDfod6jwBWZgLDUnLLkdiekWfgzNqGXIEJzfOVxc2r71zfX57HXY3GFc2aMHqfEXoh816Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(6916009)(316002)(1076003)(6666004)(9686003)(478600001)(33716001)(86362001)(186003)(83380400001)(52116002)(6496006)(66946007)(66476007)(66556008)(956004)(5660300002)(55016002)(38350700002)(38100700002)(33656002)(26005)(4326008)(44832011)(8676002)(2906002)(8936002)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9m9j6bXNQqoTJjgB+l7SWjDNua84+gCwUl7nBtg2J1tApaAOSa/IfEHBdqiC?=
 =?us-ascii?Q?MtG8aix/J3+t6nc/bfTkD29EqxJ1kTbr1OeFmlwIneMJhqll1q9zfQ5XhYd3?=
 =?us-ascii?Q?/qZa/QdYnI7Q7//gWiHnS4TOsb7tJ0eHTPI9apq2pZGFnvugv7VikwpJkAEj?=
 =?us-ascii?Q?ZjnVob80953MhQqyoPeLsoVgjYSM71lvuXlvvr5uR6tsI6O+HshSVp9S9ErF?=
 =?us-ascii?Q?UW7V/9VyuFhbv5UQD1Xtr8heCUeQ1eLvcbUTZaMr06u18bhOODx3itHkma+S?=
 =?us-ascii?Q?ru6Q+mm8aeT400+mfNYFpR2xYUM7UeBzLO++/jF8yQME/JLMYvvb4NWsQYU2?=
 =?us-ascii?Q?8xJj6M+8w67Gz3wXafMHZjYZR7L3VeV6O/f0G0H0t4GGukHhBrhWvlnChODL?=
 =?us-ascii?Q?jDYXPAd8PR+dGYioMnWv2IoIuYIbvpkOzYrZNB9E3+PYh0zwy0zaNHNe5Huz?=
 =?us-ascii?Q?eLTpIpkMP6M6Us4BbA131+74385nI/uCDWc+r9Ho7J7gg7e7l9Imo2EtkstY?=
 =?us-ascii?Q?2bXH1+/adrJ+YswnD+gd26Uk5o5R3Qewo2i1vOXIwtpLOjIH6WTXoh9v8MRd?=
 =?us-ascii?Q?kI7E4X2D8HBHtJ336e3lqte/kU5XSmV9LoY0h3/scKbyHIrxcsOEbeXD0TNQ?=
 =?us-ascii?Q?6by9aqdCvJ2jLJeyjEkYlpCSyC8iETQ/FFHCTtZOKJszNXaYPLfL0kE6TT+L?=
 =?us-ascii?Q?v7cihTccytytr7I5dOzxrPjTDzo+RB1qVXdSrvkarkoyhmDhJ5/BrWyIQUCN?=
 =?us-ascii?Q?lJmXi5eByigtki856D8sh5122ROEZbpS9CUZ18VLoN44ZwqMrUCSeLGu9g+y?=
 =?us-ascii?Q?z2L9Jt6REZsmzL6jJeScJiY3hcFldlCdCDus9DLmEtLxTDo3PnRC5nN7jQQw?=
 =?us-ascii?Q?6J8kUE7YV7CgegWxgOMJ/flXCnLooEVDLAgNLD68Fv7nivwJcUgdZ6fLphES?=
 =?us-ascii?Q?IszjvJ2CK8rYNppK8tgtV//uBdCb6J6/r0yPC4Avs5YS5mXnbMqiAOiT9xX8?=
 =?us-ascii?Q?Luy5WyaJ27yvw0DNSW2hq1ZpMzC57hQESP0JH9fgYGbKPg5YviKDmuQAGhZV?=
 =?us-ascii?Q?eiE+HpDNuRL1uSWKLf98VOJ0CLpT3RSrf2wTK58ajo2N0Uc1yDo42p/qBfCJ?=
 =?us-ascii?Q?Mh83HSLumNf8pAUjsxMG7OJO8giNhhHvIqQfJEAPKaxEeuRhBOcn2+gGUtOO?=
 =?us-ascii?Q?c1/qeyGOVUAD5VqdZIzkYOaZQTPA3BxPfp4fWNZ40udKVx7Yozr8DfCAI3Ka?=
 =?us-ascii?Q?HyQ+EZ8D1UaJbeQiDtDwdJGl6FT9/mDGMCDcOhMJ2Vq0YstwSTzNIj2XVv2A?=
 =?us-ascii?Q?cA1SspHy0hY4MHxpKtU1qUO4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2376c81-2ace-4e14-9129-08d95bdfe06c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 09:18:55.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGh0kFIN9jU8ZIKPC0UuaZdfczXvEv+XL66hJHXhJT+i0/RYFddfm4GGbYJUmnSPmdWlCz1WX1i8kSvmxWELIjJNHn51JhmCqQR10yl8FzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2320
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=616 malwarescore=0 adultscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100058
X-Proofpoint-ORIG-GUID: ndy0zpSQmW1-Rx2nAUZ-gLMuMXSDOt1g
X-Proofpoint-GUID: ndy0zpSQmW1-Rx2nAUZ-gLMuMXSDOt1g
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Jason Gunthorpe,

The patch 921eab1143aa: "RDMA/devices: Re-organize device.c locking"
from Feb 6, 2019, leads to the following static checker warning:

	drivers/infiniband/core/device.c:712 add_client_context()
	warn: missing error code 'ret'

drivers/infiniband/core/device.c
    689 static int add_client_context(struct ib_device *device,
    690 			      struct ib_client *client)
    691 {
    692 	int ret = 0;
    693 
    694 	if (!device->kverbs_provider && !client->no_kverbs_req)
    695 		return 0;
    696 
    697 	down_write(&device->client_data_rwsem);
    698 	/*
    699 	 * So long as the client is registered hold both the client and device
    700 	 * unregistration locks.
    701 	 */
    702 	if (!refcount_inc_not_zero(&client->uses))
    703 		goto out_unlock;
    704 	refcount_inc(&device->refcount);
    705 
    706 	/*
    707 	 * Another caller to add_client_context got here first and has already
    708 	 * completely initialized context.
    709 	 */
    710 	if (xa_get_mark(&device->client_data, client->client_id,
    711 		    CLIENT_DATA_REGISTERED))
--> 712 		goto out;

Hard to tell if ret should be zero or negative.

    713 
    714 	ret = xa_err(xa_store(&device->client_data, client->client_id, NULL,
    715 			      GFP_KERNEL));
    716 	if (ret)
    717 		goto out;
    718 	downgrade_write(&device->client_data_rwsem);
    719 	if (client->add) {
    720 		if (client->add(device)) {
    721 			/*
    722 			 * If a client fails to add then the error code is
    723 			 * ignored, but we won't call any more ops on this
    724 			 * client.
    725 			 */
    726 			xa_erase(&device->client_data, client->client_id);
    727 			up_read(&device->client_data_rwsem);
    728 			ib_device_put(device);
    729 			ib_client_put(client);
    730 			return 0;
    731 		}
    732 	}
    733 
    734 	/* Readers shall not see a client until add has been completed */
    735 	xa_set_mark(&device->client_data, client->client_id,
    736 		    CLIENT_DATA_REGISTERED);
    737 	up_read(&device->client_data_rwsem);
    738 	return 0;
    739 
    740 out:
    741 	ib_device_put(device);
    742 	ib_client_put(client);
    743 out_unlock:
    744 	up_write(&device->client_data_rwsem);
    745 	return ret;
    746 }

regards,
dan carpenter
