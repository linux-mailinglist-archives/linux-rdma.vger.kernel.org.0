Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989512C7E4F
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgK3G5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 01:57:21 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:34304 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgK3G5U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Nov 2020 01:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606719371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDuQAkTsnj8FhrN17vjgNdOW8DJZBKIujANyx73Gqcw=;
        b=h4X0isYPVYN1dwoeqsLo/G+5aJBZoVK7CYoFkH1Z7uhmcQ4FkJeABeFzR3tioa71epKJPK
        fOSSFjtJHxuuZ+UPb5z4MQZopve9HQUQsbqOnZbYUe3IJs0NCdMM6z0HtxajD6np058miv
        J1HfH9f13yc0ZOmQ9R5AoKJQD0WjOSA=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-f7QVeNlpPrm5Fk3PMvTY7Q-1; Mon, 30 Nov 2020 07:56:10 +0100
X-MC-Unique: f7QVeNlpPrm5Fk3PMvTY7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3MRDdPfiHwPteS1eJON8sZ5Q96U6B/7EjOUcEKaVkKVOWHdpqWXNmcXkyDHcHnfhLT9zKF9pRLi1BMwEj9nuaETMZ5swbXmKsdqnWkxsQfnrtq2ZEqcHA9wB/ncAYhaIZwaBLzuGZNBxjNcSmmZSy9DrpMMsLnNEC6yC7WZL/LcVIFwLYkf17hrptY+ekNOzEXdQZCXcN09uA2lxwVmFzlXMpfALN7t9YjcjoU9yySJvHUDRNbQyJSGWLO74KpE/g2YhqdMtUT8MZvJOGKerirTpgO2c73q6VjLfx+ZiW7gud8q+39/KhcUva1wpdXx43Y4qoCuzPtnLK7j3EMe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riCc3e5pYFZJH/ALzRrSi7rQTkBBQCGgJlp2KHT5g4k=;
 b=FKTNHUhxSwdo0PDw5k4coahv5MAp296rQkaG7L4WeQJelXjJsXK5kIFJB46uMi0rX2OXqvlnnYaii9tXYlgM2+eiY+p4ysfH3i9H0QIPeVEx+iYOb4LTJi3tPPVMynnWHihGUUXUmleg/dJKiIRLIwYppEQRychyX2L9rLF2bNmfHDN7S5qHwxFdhPiQT3VEBJ5/ywpu7S3rU0bKL1/V8DLoSp0s95MAJu2PJMlMgC8AwqCKu3tOJ8WDn17SYIOjbSXS3F1Yqcu08jOoSK00xyBxatsBzi6WnrQCXH9SuRQwIJSozDE8hYB+4dwDuonY316DEj/5q6Pr2Dxb2dkkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DBAPR04MB7399.eurprd04.prod.outlook.com (2603:10a6:10:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Mon, 30 Nov
 2020 06:56:06 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%7]) with mapi id 15.20.3611.020; Mon, 30 Nov 2020
 06:56:06 +0000
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
References: <6c9f38f6-de5b-d01f-f67a-52a518d2a26d@suse.com>
 <efe241f7-6acf-3d39-b29c-fadefc7939d3@acm.org>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH] RDMA/srp: Fix support for unpopulated NUMA nodes
Message-ID: <3d3b3ef6-3d24-7322-3006-c974c24415b7@suse.com>
Date:   Mon, 30 Nov 2020 07:56:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <efe241f7-6acf-3d39-b29c-fadefc7939d3@acm.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [86.220.115.126]
X-ClientProxiedBy: PR0P264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::23) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.220.115.126) by PR0P264CA0131.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 06:56:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 568742d5-8ab4-4518-fb07-08d894fd025c
X-MS-TrafficTypeDiagnostic: DBAPR04MB7399:
X-Microsoft-Antispam-PRVS: <DBAPR04MB7399D52E6E3C9F7E7D493F80BFF50@DBAPR04MB7399.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkS2vWrSB2AbGJYxQyaIMnw7hjtZyBc79F40B45330qxjXAyY4DCvyaeBvmTgEU0EEmEGnz/Q3MYecCSFYcTBDRj4j/xJq3JcJNg26hzfis4pUv5d3mTE2mGDczHWjyWenb+a/jUD550LNJw1UCcH0/fxYY0RZhl5IWKhLAr5OnYHSBvn7NnKrZ7MgcDFW4oFZHMj8nIgbmDSJ1mQqGBrshmTr1Sde4YasNCrPmioxAgarGANs1BPjnacASYkIf2z8egCaNC3AWaGXv3XHhA4e474i7DshFy8RXRzTXnSQXi/zdtAGghszWwDtssRwU8g6dRjcjG76M3WQLHnDNEkBNXn6rH7IrTF9XOOGSA6+GkLU+oAft9Gn4WmNdeKzEo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(8676002)(66946007)(66476007)(478600001)(5660300002)(31696002)(66556008)(2906002)(36756003)(26005)(53546011)(186003)(16526019)(2616005)(52116002)(83380400001)(956004)(8936002)(31686004)(86362001)(316002)(110136005)(6486002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YIhdrqmtxeyy+hq3ns4UX6+GkMTCabV4OUmMdySkG975/mCkauZ+yw43ynD5?=
 =?us-ascii?Q?+a4YruUqF+Sggo7RX51bFS6KwhZAOy6QS7u5zuNWG1H8H9OjQlRqvxoy6EMm?=
 =?us-ascii?Q?xFSt8KLLLaxtgHkImbpGlGJpH9MvhAMixcbdlPCYBGHK9yBewwjH8cA8FiHa?=
 =?us-ascii?Q?wLDfvSR9mK8KC8ODOV+ChQAUtRa2rD69v15wXx/M/39VkEDSq6CIPA3mZUep?=
 =?us-ascii?Q?6EGaOxX85KIwT67cdt6m+tV7FCkoQ69TWr3G8kUS7yygj3fuz8AqbbWKr7x1?=
 =?us-ascii?Q?gvqIVb7Ak7DojYDTWPWHVdzphbLybLlrOLmkf2t0DLtHsyEpodm5Sk2NdF5f?=
 =?us-ascii?Q?lpQK8+e0YiOKY8N7P59N34mQnj8EPIm6fUoN/HtC6K/Q1MIwfnPSl9QaX654?=
 =?us-ascii?Q?NdiN/6iJ5oimv2CisX+a9N6AP+3X0PbVvcoBTK+3nxnzEQMeoLs5UlLrLTAt?=
 =?us-ascii?Q?Wrj3CU7SHnUXhTCgtJ4C8WshXyUkmYXFPk8+28C0wG3jvpxzVR+Bf9uBRJbk?=
 =?us-ascii?Q?Mq48Jqx3DtWVr+AwfhvzdFxwVg3nqAulw4Yvwx6ovOtZFmMtMBVw0rdRNlHG?=
 =?us-ascii?Q?AJfMRQPCdoyJ4XrVuZyTWruB6SUZWLNpY7yw63VD/s0TJ+3t+mhnqLo8IAbW?=
 =?us-ascii?Q?RStlxp8Wdr92O22OExuXV3DB9JHjgtrzFvavIB8sfF7dnkFJhVZAsVwdzv1o?=
 =?us-ascii?Q?HqCTzykiDOkOx3aP0O6e50gXjf7uz8FL/dFCHUnCmoDU7eQk1gUxFT2Qy58V?=
 =?us-ascii?Q?/t5yqLI0qyxDPrO+BPWRbARYe4ryu8+KYYjXcVmH5ae4M9fLhDa7iEUcOTnq?=
 =?us-ascii?Q?0pw0XzI2CS1iMEA4d2yRCZavkjl/kwsl1TTqAWO+tsay+e4Zf1QOctCVoLX6?=
 =?us-ascii?Q?al5OHoLgsJaiTvY45Hqg/JUdXLfIP7R/0SKuI7Cga06v//Eb+DxKZ5t0gxYl?=
 =?us-ascii?Q?B9KNxEE/YAw3PESFPw0BTf7QC8GwKEKQXzg2FhAGif9DhD3jgNtyeIYgpPBM?=
 =?us-ascii?Q?v2Sn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568742d5-8ab4-4518-fb07-08d894fd025c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:56:06.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLukEK3FXluUnLZxjFlmKeboDbnAVZp8JnX2Mfk3ikj+63NpAg3DxQwC04JK754lSrMEUAHf3GrdU96QO3D2oMDeDCY4tm7tByCVtqSWe+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7399
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/30/20 5:07 AM, Bart Van Assche wrote:
> On 11/25/20 10:26 AM, Nicolas Morey-Chaisemartin wrote:
>> +static int srp_get_num_populated_nodes(void)
>> +{
>> +=A0=A0=A0 int num_populated_nodes =3D 0;
>> +=A0=A0=A0 int node, cpu;
>> +
>> +=A0=A0=A0 for_each_online_node(node) {
>> +=A0=A0=A0=A0=A0=A0=A0 bool populated =3D false;
>> +=A0=A0=A0=A0=A0=A0=A0 for_each_online_cpu(cpu) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cpu_to_node(cpu) =3D=3D node){
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 populated =3D true;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0 if (populated) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_populated_nodes++;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 return num_populated_nodes;
>> +}
>=20
> Does the above code do what it should do? Will the outer loop be left as
> soon as one populated node has been found? Can the 'populated' variable
> be left out, e.g. as follows (untested):
>=20
> +    for_each_online_node(node) {
> +        for_each_online_cpu(cpu) {
> +            if (cpu_to_node(cpu) =3D=3D node){
> +                num_populated_nodes++;
> +                break;
> +            }
> +        }
> +    }
>=20

Yes your code is better and mine was glitchy...

>>  =A0=A0=A0=A0 if (target->ch_count =3D=3D 0)
>>  =A0=A0=A0=A0=A0=A0=A0=A0 target->ch_count =3D
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_t(unsigned int, num_online_nodes(=
),
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min(ch_count ?:
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min(4 *=
 num_online_nodes(),
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ibdev->num_comp_vectors),
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_online_cpus()))=
;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min(ch_count ?:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min(4 * num_populated_nod=
es,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ibdev->num_co=
mp_vectors),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_online_cpus());
>=20
> It seems like "max_t(unsigned int, num_populated_nodes," is missing from
> the above expression? I think there should be at least one channel per
> NUMA node even if the number of completion vectors is less than the
> number of NUMA nodes.

Makes sense. I'll fix that.

After some rethinking, the current code is still broken anyway.
If we take a case like
Node0: CPU 0
Node1: CPU [1-3]

We'd end up with a ch_count of 4 spread equally across 2 nodes.
But because N0 has only one CPU, not all associated channels will be setup/=
connected correctly.

Would you agree saying that each node should have the same number of channe=
ls?
In that case, we need to count the # of available CPU per online node
Then:
num_ch_per_node =3D max(min(min(min_online_cpu_per_node, 4), (ch_count ?:nu=
m_comp_vectors)/num_populated_nodes), 1)

target->ch_count =3D num_populated_nodes * num_ch_per_node

This way we ensure that:
- There is at least one channel per node (max(..., 1))
- There is up to 4 channel per node min(min_online_cpu_per_node, 4)
- We don't overuse comp_vectors (except if rule #1 requires it) and get a v=
alue as close as user specified ch_count respecting above values.
min(..., (ch_count ?:num_comp_vectors)/num_populated_nodes))

This by construct will always be spread equally across nodes and fulfill th=
e legacy constraints we had

>=20
>> -=A0=A0=A0=A0=A0=A0=A0 node_idx++;
>> +=A0=A0=A0=A0=A0=A0=A0 if(cpu_idx)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 node_idx++;
>=20
> Has this patch been verified with checkpatch? I think a space is missing
> between "if" and "(".
>=20

Will fix this next round


Nicolas

