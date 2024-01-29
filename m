Return-Path: <linux-rdma+bounces-805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00C8414CE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 22:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A998E1F255C2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A86157028;
	Mon, 29 Jan 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="btWtXCc7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QC6Ym8pI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56812B86;
	Mon, 29 Jan 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562245; cv=fail; b=BBqFLC0Mc81cj9G2v6XQQAoURmR4DzhoMIDucRZloDem27onib6PFy1kxqsH1O4h7UeRU7cEGPLeGt7pAp8AZYv/d/jtMHUQHxBzCDsTGcl1bFKkZw3QVMzymGu+m4fFvmVoSbVMBjrt8Aeb89zv539y4EOB2hOVDGJTfqH+bTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562245; c=relaxed/simple;
	bh=RtpzoOTPTrtUUCO0ZktWqIUngiBNXrfKXySk8Q178Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+8QzC5MjZIAPsa5D/nATUM1RTzVoICWYRZxrFNHEcjRHaH0Xx+JJqdSZe8/TfIef4AzT1qBSCzh8CIvHH80sJ/4qmA1PSBXvR+HpJGk10vmzuY/tJvJgUCFZ+nU/LKuz5YF+hfIRYkLITr6E1cJl0bx0cjDJ/kOcPbXD5fGKGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=btWtXCc7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QC6Ym8pI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi0Ht029557;
	Mon, 29 Jan 2024 21:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RtpzoOTPTrtUUCO0ZktWqIUngiBNXrfKXySk8Q178Ig=;
 b=btWtXCc7OgACTYzfr4yzgKMU+9Mv0sWHsxxcGCbaK/d9TjDI+yNNz8rZdy650JhCUy2v
 GV95wTPz+KOlP0q5/jU5YnmlI5cuY33WsFi4iIUIMrE3P+AHsPVk6kAnhvZaPeVJHFYc
 1wLVYwEWehZFD6K2WTloWzZ6qLf+iOAZr4vz16FfLDy88He81H7WSmz2NGqC8z2rPEWv
 MQHYL0i3lToyjHeA0ghtl37CWnOGTxMR6ne6gVoJdYYN+Y2eEcr4kz6SSouIb1odRFkP
 NR+wlrYgJLur/gyZJg9RJQdnfPx7NW5B3/7f7nXOfmtdUBgrfXuTQfbT8Lwv3wAN5f+f aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ecxn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:03:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJZFob008435;
	Mon, 29 Jan 2024 21:03:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9cq6n0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYA2i0utDfMsiaqG2bzjN85PncOvGqJ/oEpz0DNdcx/mQX38Pin0FwXptx+jXmKWJaGkxrdmcFIpwTxawR4jKpH0IsI9IgByH5gC4WhDv0xmFLiws/R4sUdv1KvtXA/YNm6ZSEYZhT8TOa2uMEN6qdIJ2Rnn3c629/9lBmWI74qb51mV22nj24t7PT2WRYYloy7cPdd+WxtGohadz21muN6lUyivrGKUgfKBxhiunMb9et3+cNfonwdOc6G0nRH5No9411z6PdgDVTiJnnwr6+pAwEAa8ThkaJHPHPYp7Bk2/EirAJOc46UknncrzCKRyK75eg+FgyaQK4blbcH+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtpzoOTPTrtUUCO0ZktWqIUngiBNXrfKXySk8Q178Ig=;
 b=lDLMcQZLWm09/SxkYSutcD7QINK0YP/y1nkV+HMlyqMGiFyKzm20jDdTUrxtWSQBcyso5znXdDYXtYVSpH/zPoji6S9vAs9rHI3wD6tjgk/V0M7IiIm0tabQkyRH1hjMb6EX9GC5gSDSeSAwJMwfq9zbanCwHf/9YFihUmrX3+nUr125lYmZSTKsXCLdbIxjLO2fVZKe0uhSTrlK/Qu7W87weo77y647OVonA7Jj+NGVWxs/FTiG6t9j0pOYoXPcLucsQQNDj9vLr3FHX28dw8TtagPnbl3HEOkUOeXWSCBBf7q4+wyOzHyZOLe4nTr0oNqM/ryfETS9UMjf5Alo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtpzoOTPTrtUUCO0ZktWqIUngiBNXrfKXySk8Q178Ig=;
 b=QC6Ym8pIRSa2ajvSFSHuGTn/gQRHg9xxhvi6kgOb3KSmc1FR6z0J+wGTp+WSJlHoU1HraU2rsnYEaIXB9CInJKbjznTRwJm3/bOc07RV9B7o/B37jV7/bHR5uDVEckHWHrOj2ngQv0lAcMoVdl5GFFUF1y1lQWC+dwD1G0wZm0A=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by MW6PR10MB7659.namprd10.prod.outlook.com (2603:10b6:303:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 21:03:34 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:03:34 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Santosh Shilimkar
	<santosh.shilimkar@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>
Subject: Re: [PATCH UPSTREAM 1/1] rds: Fix possible deadlock in
 rds_message_put
Thread-Topic: [PATCH UPSTREAM 1/1] rds: Fix possible deadlock in
 rds_message_put
Thread-Index: AQHaUHzb3jJU0UeqsUe2ltVgmrhc/LDs3z2AgARtBYA=
Date: Mon, 29 Jan 2024 21:03:34 +0000
Message-ID: <2b3440abbb46c08be1160678b7c50efa5d246cf6.camel@oracle.com>
References: <20240126172652.241017-1-allison.henderson@oracle.com>
	 <20240126172819.4cc13dd4@kernel.org>
In-Reply-To: <20240126172819.4cc13dd4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|MW6PR10MB7659:EE_
x-ms-office365-filtering-correlation-id: 5bdc6463-8031-4338-897e-08dc210dc177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6YuGTZ5xf/P54RaS7QDO33KZltFAUXtQmC965DlZdtJzJHdKkuo1TWg9SvHgGL24vP4mdOrYw6nyIvHaI5H6ozAWPiYf5kV6dYxo/5idrtSEzPeVML7dkovmtK0ISOveOiQUwqREuQgiZa1jAXGSFZSp2y64hqFri74Eyib7nRDD/WXlGcngWhQSkS+NA2gDbilvdr9uY8JpPgThKPsxsFH7ZjnbrWU4Pcc/Ni4MaAQ3otOSE9jk+zE5M1Moyv+eo35DD2HnHDKIVMqmRinl8T6hRyBOnZ/4VA7YC/YPA/TIRRI2u2WWa+t6/bck+NYoJaTSwqz+dtcXwgD/gfLvFicfpudU03mfMgkubE4ToF/iP4FOwCQ47sv/5+hGLVND4rVuh5L3i14V/iqzAoCLK/wm7U/jMuGyWZB6GCOaLoh7kBddxRTC3oZcPTsfOL4jqxdh74qnf9VdAgGgwN9VvHlpTb87HukjcfgMT7BXi7i9DQChlLL7jvP7hZ6/hOZK46RP4yCe6Ex7grzRYHxF4pQjQzBFVNpEitVsPSIjUvxg5DN9js9DCPGlhQnlPjA+ZoEVSgJ8UaSmoW3nGoFVoPPIjaILUdP34AlOYfb6JCzGO2PVKP2kpyWFvFsSlDnW
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(6506007)(36756003)(86362001)(26005)(38070700009)(4744005)(44832011)(8676002)(8936002)(41300700001)(4326008)(5660300002)(66946007)(122000001)(478600001)(38100700002)(316002)(66476007)(64756008)(6916009)(76116006)(54906003)(66446008)(66556008)(6486002)(2616005)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cnJVWSttVE9pVFJMdW1RazN6QUppaFo0NDRza1FMSTRKUnBMZXZudzBqU0Zq?=
 =?utf-8?B?Q2txVzJGYWNHdU9CQVIxOUtZaWt3clVtNTR3ZjdvakZmVWtRVWsyRlBFMDhK?=
 =?utf-8?B?cnFrblordFEza0xDZVp3TWoxNm0yN0w5dmxXOVRMSlV4bS9kbTVSN00xMmwz?=
 =?utf-8?B?MkNoZWxyU1FYRDd0T0JZdnp0K00vYTQ0dXFDVzdrb3JoZ3BnNVI3dCsxb2dq?=
 =?utf-8?B?YWlSZUd3VFFwczNZNnNxcXdlL2YvMHlCaWdlaTBQWnNtQUtMZm9rVFdVL3Y4?=
 =?utf-8?B?US9JVEwvYXpydkdDcHdCTXlSRlIrVUd2Ym1DRGEyWXZQWmpxRzliWE9RQm9Y?=
 =?utf-8?B?Y1NKS3NzeDYwSG5kMnZmN2gwNW42NlVQUnVqRW9RM0liSFpLWjg3U0xjNlIx?=
 =?utf-8?B?UUsvbm9naVlMcjFxaHNsM1h5dG5jdWZIdFk5b3NQNWJyTk1sd016TEdzamY2?=
 =?utf-8?B?ZnoyMmQrTGJOWm5CWGZVMnR4Zy9RYzRYdVltbWs3S213UWo3bkM1YjZUOUE0?=
 =?utf-8?B?L3NFaUZkblVDa1c4OEs4cTBxYTFKSFJhellPQVdsZW9NYUtXOGNmZ2hsNkg4?=
 =?utf-8?B?SUtMNU9wVTYyMGVzdXhzaEFjZ1NDSkR4WVVmYkM4aFRXU2thVHhESXNham1x?=
 =?utf-8?B?YVFYbnFPbG9RclJScDFYd1B3TTAvdkpReVJmWDRkU3FuekJPbVVxdnp5a2ow?=
 =?utf-8?B?aXZ6SENVcm9XS0lnR3JJd1ZEdTdUVGg0YmFnVG9FVGhBRTdraGJ1SWc0d0h3?=
 =?utf-8?B?L0NDc0lNYnJ0dkVXNGdoYVA2Sk0zazBUb0d6UytYTDUwdXk3WUlYSTR6S1dB?=
 =?utf-8?B?MHZqeXJNdnJVZEd4ZFQvbm5SRVlxRzM0VGF3U1Z5M3lyZUJLN01zczVPL3hl?=
 =?utf-8?B?ZUNQalVHQWt0amlrYnJ5Wm1yZmNJVm94M3h1dlZDOWVPcWhIOVcrRWkwTjNv?=
 =?utf-8?B?K1JiTXUxZys2ZHhwRGxZdm4vMUNqeHdodmh0YkZ6TU10R0RhU0lrZ0NobEFq?=
 =?utf-8?B?VzVxV1FPZWk4ZUE0aExFTUQxTysrRDdBb0ZzcXphajlheUFHSGJqMVBHY3NW?=
 =?utf-8?B?VWZxTk42VW8xeEYrVGZscGNoTytRdlU1MTRjWjY2cUhGbEQxY2UyMEh5Tm9R?=
 =?utf-8?B?VUhGMGFncDEwSU5ocVpuZGtzSnVUQnhCa2NLeXZ1cnVvaS93T3ZYcDhkTmJi?=
 =?utf-8?B?ZzE2cGZReE5Ncm02NlEvaVJmZ1JKUEp2ekxRVVQzdXFQcy9lMG1leGwrMzA3?=
 =?utf-8?B?bXozY2xTWXJEd24zK053RHRPbnhkU01GQVZZQzhYUnNrS2pyQjRmTlh5M0dT?=
 =?utf-8?B?U0FIN3ZOL0ZiZEw5SnpUK2l4NFN0ZHZNWG02TEZNMXU0V243Y3UzL1pJNTB6?=
 =?utf-8?B?ZGpHR1BrcXhpdmN2cllXUDFnRm5UQVVxajdsOUZqYTRDWHlCbDUvc3RSaU1G?=
 =?utf-8?B?UlRYN3JCQlpBZWNrVFkrd1VReGluOC8wSXBIMUNhWEsza1c2OXBFQzNpU01I?=
 =?utf-8?B?WUloZTVtb1NENmRGQndDRURiQkNaS0h4TWY0UGFrTjRFYUh6T0VsbGRJcVVj?=
 =?utf-8?B?UVRuc0xZTkpuMWFya1NkdHRQOGh1TmdZdEJETnVaLzBHT0d6YkRBNmxBQmFZ?=
 =?utf-8?B?NFQ2K0FlMERTVFZ6TG5XRGJ1aHBCeWtEaEQyWExWaDVyZzM5T20xUitHQmFP?=
 =?utf-8?B?eDBEVUVWQWNUbTJ2NGs4OW9DU2NiRTA2eXFocFRUZ3NrTjF3bUxlUTF4NitB?=
 =?utf-8?B?UjU5WWV4T3JkeFl1R3NPdmhCS2JZb0FFeU8zUUw5a1htNTl3eGFiRndwV0My?=
 =?utf-8?B?ejVIa1YwWnk2VDRtekd3M0lKd0k3N3RrbkJIQ0JwS25jNXpKK2hHZ3hVY0Zz?=
 =?utf-8?B?MDR6ajAwRTZlZVVZNjBJWGpIYTlDRWlIdTV1SDIrWGxkY0xhd3N3Q2IzZVFO?=
 =?utf-8?B?cjBROWE0TERyVzNDUGtULzd2VzgyNFZPQXY3bXNDOG4vVUFLY0pja1BOcVZL?=
 =?utf-8?B?Q0pBWHoyV2VRZ2cyVXlIK01jOHJpZmYrK3JGbEpMUE1UaWRtclExSW94eUFz?=
 =?utf-8?B?NXdJSzR5cUhBZGtnNE0weEtSN3FjalpTa05xSGpWUHNDblBZVkFZZVhpRWlQ?=
 =?utf-8?B?dm52WnNmaFRCRkp0N1RKMVpLMGFzK2diRnhEdHV4cnhGdnBrTUMyU2p1OG5R?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99B4862510121E4CBACEE5EA7A5DDF6E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3SxiwpVtdvL3gxIAgU8iOwrk6ljBT92AvOKeCGX/fjLBWi2j3pQkyEDjmqcCMxXfzc5KOyJ9D1xQCiWHoEPXoRRPZTzsrPgqFYL1plOFkamXIPTJ60LtRRgPVBVFFA+Swe5iuUAlAEWCLEByQ3S+Q3Oc6W2L2il5QqKSlqgHAEWYwufOruCQIoJnnqoDi2m/LtMVwG5AG3P+fMjvuCSG2Rx6Jn2mrEJmOk+8PJaQxF+xIQSIgWrZ678YU1o6oduy8ryzRiLXP2NZlyC+XnadjRnkGA0zpeToAEGn+p6RiNJJOgJXCV2+KC/AWsndeUADCAU/wQr1G80Xy+0Tsp0rBN49glb3L9cgXxe/B9nKsmcNk2v3qMq0d+mfuXjlbK2jg/SUudtgHKU/hGcEsTNoh9urMrTqs9UWdeL/wOe3N0/V56bKVKN4Jrg4bYxRFpkEgk+DqxMGRh1Ygw1hvdhwccBpF+DG2KmiMdEyX1li0bkNM60rg/u43ltv5pmtKmFWCRy7hrCSUqu+pn73QAVVAjbe0y377Uz1aXi4N/U7oBxvtnf58WzjbU61mRYMmRKJ9gjXSa4fCVn6Szw97sEWrjW6l84PnuCdKvdm6ByP90c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdc6463-8031-4338-897e-08dc210dc177
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 21:03:34.3289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OnUHQ1l5MMSBEEC5yh3y2M7CyOBUCbnHoyB4mDhUtitcmxOt3c02DUI3aPyRd9dhYd7iys2pn7GTjL4p8e9SspQyNA6xybfQu/mWuevdZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_13,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=857 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290155
X-Proofpoint-ORIG-GUID: bb56yTHnlPK7y7GikjRdLqIWEi2mpmQG
X-Proofpoint-GUID: bb56yTHnlPK7y7GikjRdLqIWEi2mpmQG

T24gRnJpLCAyMDI0LTAxLTI2IGF0IDE3OjI4IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToK
PiBPbiBGcmksIDI2IEphbiAyMDI0IDEwOjI2OjUyIC0wNzAwCj4gYWxsaXNvbi5oZW5kZXJzb25A
b3JhY2xlLmNvbcKgd3JvdGU6Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAodG9fZHJvcCkgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJkc19pbmNfcHV0KHRvX2Ryb3ApOwo+ID4g
Kwo+ID4gwqDCoMKgwqDCoMKgwqDCoHJkc2RlYnVnKCJpbmMgJXAgcnMgJXAgc3RpbGwgJWQgZHJv
cHBlZCAlZFxuIiwgaW5jLCBycywKPiA+IHJldCwgZHJvcCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIHJldDsKPiA+IMKgfQo+IAo+IFRoaXMgZG9lcyBub3QgYnVpbGQuLgpPcHBzLCBhcG9s
b2dpZXMsIEkgd2lsbCByZS1jaGVjayBteSBidWlsZCBjb25maWdzLiAgVGhhbmsgeW91IQoKQWxs
aXNvbgoK

