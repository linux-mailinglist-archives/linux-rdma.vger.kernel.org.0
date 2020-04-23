Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75C21B5B99
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDWMk3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 08:40:29 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:63394
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgDWMk2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 08:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaCmEyccSEV6t84cld50+jYjz9NAKpYTyXi/KdqK+z15+SwqyfaLwl/Mwk778co9djvOCVPChkjTZajStwwH4aICPzPq1p/LS1m8MmQ9x/G/VNLxePkf0bXP4yNLoIoSrHDgPF1Qtqa6xZwLVUCWGcZ9UTFS4YoDAPvbKmn+sNrdyP61otFHEZLkBEKdMyXc1XUn6jrMESBqIaFKlYI+auK2oAxSAw+VogdTSppiBBLNEVeV/3UiFIrKP49zkTaVJi/s5TITpjIwucZTrK+1M6u2F8y3keBiJdmEvq+tj+WNVQMzK9c95APmG1y1oHRTiShu/H+zjrezOYlEIhEUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1eJuPx+yEKYOxMMDPXwOZTIcWXKNH4bWiPhMZZmaT0=;
 b=ShBwwkf95SBM0ZAiLZCNW/kZFfNW7THi91wpEainTheDXsXx7869iizTek1z/dS9m7U69/ekMp4pPBXXwl8XKqdvZyHSryYDSgk1vtCGWImdMsmJhqmWoZuInBmf/zGxTjdu5D3T2LrcBNOrX7sMZHeh0FsJJHPviY9i2VAEEDOOpAeSbX0z/fj0eB4PfbLZIiw9f2cx6dPSvKh9Mqq/0EtkUQMATeIPuWWYEMF0RxWrl1aKlo6F/HapONXZeY9XxoE5kyipiLWl9AGO/RnMESpR63P2256YMjOTVCgIGJqiBxgrlZ9UW1GNpeApw3bNOEXgTqboPqoMKtb0J6LBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1eJuPx+yEKYOxMMDPXwOZTIcWXKNH4bWiPhMZZmaT0=;
 b=jKuuYkZ5e0WtjqeoBnMhsXf6GIGf7V+T273UxTwQCo6y255IpUSQ2xXI7nteodSR8b/rPaD2cpbV/7I1Ocl/6/2FlbZS4MAJThpsrBnfbldhCa2p7mhYhSuOCqMn3p2yM6dBfi8kI66577On8C857S8EG8shDmST0e0Kg1P15do=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4612.eurprd05.prod.outlook.com (2603:10a6:208:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 12:39:43 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 12:39:43 +0000
Subject: Re: [PATCH 14/17] nvmet: Add metadata/T10-PI support
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-16-maxg@mellanox.com> <20200421153045.GE10837@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0c6caf5b-693b-74af-670e-7df9c7f9c829@mellanox.com>
Date:   Thu, 23 Apr 2020 15:39:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421153045.GE10837@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 12:39:41 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7da80e5a-fd7b-4c64-ad3e-08d7e78365a9
X-MS-TrafficTypeDiagnostic: AM0PR05MB4612:|AM0PR05MB4612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB46121F3A9AB8A02001423B32B6D30@AM0PR05MB4612.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(53546011)(316002)(8676002)(26005)(186003)(16526019)(52116002)(36756003)(86362001)(4326008)(66476007)(66556008)(478600001)(6666004)(31696002)(16576012)(5660300002)(6486002)(81156014)(2906002)(107886003)(8936002)(66946007)(956004)(6916009)(31686004)(2616005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcR9A663l1nDP8wX6Y7+C5f16tqhP6JmZjXu12P7mGcsJfpHHr3Pz1CAxfV1UbOycz7Vf6t7iKV15oVuvAXC1l93BA+fylD7THwVhkGoJc3aj4YBw0NLBRc59hM5z07uSEqPjne6VB23tKbWx2ttp+/Z0rYdngyl5cgbfPkWO57DqNu7JN6VKgdpzTqys1m5TE8+YoQAa5a7kYfFz3f7rvN3tH2q3ejOThHlRbSJOkBWujzrm+fLPIBPNVDqlDQaLhm+NCU5Us7nbK6GfMQ0imPODp2HuM3vK8TdKVxzk9lvoMriAtv2k5YjoTPw/PN8CciB5i1z3k4n6OutoIUwS3g/GiJe7bYOo80n4l/qUQmKf4qUda5rP694pm+Y4BXyTVDz9EuFh90b5xkk6qgazHMH/wJPZOfvhFchKNZkvE26ptUtAFSlrIphc2ylahbm
X-MS-Exchange-AntiSpam-MessageData: +eN0FFpMm2dmRvv9X9Plz5z+Z6Pc1v0YotDm4UDSVo7JmI/LJHRfx19FsVZQ+42fCZYRL5AqxjYJy4KSL4fU/5uZyhmDlJ4aY45es2J+QxCSZMN5nbWF40jQx/WHqRTgNQnBCCIa50F/Zw+LFMigdknBFeDjBGTkPMyJgRqRhPimom/3ViGFyWTmcWoFxy6GJP9oT1f+YnpoMpAiDWTXDftPGD1sLShdsuLE61dDxJY7snNztHhaIR8vjSL7+N6Xn5kbu6MF6vogqUtFjf7rDOrx1i0zf8Eemi19OU+uHyKqDQOdO515+eSdGuPJFeBQKozOKmKp+hzEqf6+lzE1774vdIpbygx/oVV8ErbNBQ9HbsBHDl6ZvKWE0qJI+Xa1G34C46pJtJSCTYqE1MNGdb26FoeOLZE5E0a/eVaS95o/0syNIRQHsACdMYU05sisht/CZKHzuvyO99ox3DWmqecYcdCCyq1uGdob0LyYbKn/aGRcKGENpx/Uutklr8NzckZaK+mYCXx2O2sKwFgcNvDTucu/VA7QK5hDLxPZsVoG49WV+c6qm5veRRuBcRrAPw1au7bpvPXTPRs9dfcTQ+WS4bh4NhKbEufL2b2MBqGsPGcbicCzw5RfViAgWDZcxlcAw4QNcHfYAvcYSo9cscYHIf0evI5cVKDGR5Ply/ERdhKF801CPjD66p48j2BcjnSGubVGa4tOBAb6xFqnae1806sLKygRzfFFD+4xrhLoYQb0Z9DEM9UvnkuCEjj8UgBbYwcNIuo3l0z8b+yRcI3kXcR+p20ue2JiNbPNWmoPNqZg8trRTE/jyzpbOWbc
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da80e5a-fd7b-4c64-ad3e-08d7e78365a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 12:39:43.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEZ7YXd+zWygT+eHKxCtaf7w275cyyNZpOV/6s+P8YNhn4IPC76Bp0sxpL8sBGKSvtfnEmhNCXnqUaxSl5b3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4612
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/21/2020 6:30 PM, Christoph Hellwig wrote:
>> +	/*
>> +	 * Max command capsule size is sqe + single page of in-capsule data.
>> +	 * Disable inline data for Metadata capable controllers.
>> +	 */
>>   	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
>> -				  req->port->inline_data_size) / 16);
>> +				  req->port->inline_data_size *
>> +				  !ctrl->pi_support) / 16);
> Can we de-obsfucated this a little?
>
> 	cmd_capsule_size = sizeof(struct nvme_command);
> 	if (!ctrl->pi_support)
> 		cmd_capsule_size += req->port->inline_data_size;
> 	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);

Yes good idea.


>
>> +	if (ctrl->subsys->pi_support && ctrl->port->pi_enable) {
>> +		if (ctrl->port->pi_capable) {
>> +			ctrl->pi_support = true;
>> +			pr_info("controller %d T10-PI enabled\n", ctrl->cntlid);
>> +		} else {
>> +			ctrl->pi_support = false;
>> +			pr_warn("T10-PI is not supported on controller %d\n",
>> +				ctrl->cntlid);
>> +		}
> I think the printks are a little verbose.  Also why can we set
> ctrl->port->pi_enable if ctrl->port->pi_capable is false?  Shoudn't
> we reject that earlier?  In that case this could simply become:
>
> 	ctrl->pi_support = ctrl->subsys->pi_support && ctrl->port->pi_enable;

for that we'll need to check pi_capable during add_port process and 
disable pi_enable bit if user set it.

User should set it before enable the port (this will always succeed).

I'll make this change as well.

re the verbosity, sometimes I get many requests from users to get 
indication for some features.

We can remove this as well if needed.

>> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>> +static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
>> +{
>> +	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) * req->ns->ms;
>> +}
>> +
>> +static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>> +{
>> +	return ns->md_type && ns->ms == sizeof(struct t10_pi_tuple);
>> +}
>> +#else
>> +static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
>> +{
>> +	return 0;
> Do we really need a stub for nvmet_rw_md_len?  Also for nvmet_ns_has_pi
> we could probably reword it as:
>
> static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
> {
> 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
> 		return false;
> 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
> }
>
> and avoid the need for a stub as well.

yup.


