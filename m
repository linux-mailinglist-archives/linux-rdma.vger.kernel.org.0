Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E07346744
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhCWSJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 14:09:34 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:37970
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231214AbhCWSJA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 14:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjrupWk1Gpy41C4ehpUCM3DqlYwk1c6bHtMCXPKtPW7IVQ1FjRoONTbxrF9Jc11FZ2Dgpr745nwOH5/FK2kodYv0gxRLVH9fW2U0ux4A4tp+vtaovKSpSCs+wHICNuItQHEPyGaW28mSJygRfBiRHC5wPLwDfVE4PMOk3MtiaRN23CaoV8gKLRAchlME9J1R9SNa769e76UnEYBi+cqhU1qt/RnLvOkdzLw6vUFuU2iaEOOHSuNLO773u6rif7ZiN7JKlaoywdVEvp9dY2wOiLekbQpPP37WlPZdzkoOIKQdmBrqiyUuh050ucA6WkSZU4CmVZvLhFgMHCA/gkgoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5MqcrlCiPAAg2JbW4FXTQipkD79v6PUPKKSO2yAO50=;
 b=f71LVR4Mxw5mPYwhUK0VeBCMqQnKKAko7GB3x13f4/PSqtf4W+zSvkmgXjkmHASrl+vazHTIYDIfkn1CKzkLoLfLTl2dpzSUCZbn6AB4yjOaM1GsQ7VKYXqgqpQ4ZQnsUHfdcWG1P2PdxQccGhvI60Nm3bGPglYIY7bvJvacz6frCgaCbm7/6+q3nMd5ZPt+aie7LS8ln8/iu3eNAEwm9z6AvgnXiCTGhhyTFW1X3RFstjmJ4T6W99zh0KxCvXYBpaq0C+dhht+c3XZy8uSb8DvyKK+hbgdoQHDsxm8D2aez80EDLRwnVi0+pG+svU2vgNajLGPS1+Ap2ZSMvVSWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5MqcrlCiPAAg2JbW4FXTQipkD79v6PUPKKSO2yAO50=;
 b=o87dv0mkcc7ImN9804DxnWZ2e/eb6FJVoQPjHAGM/AhTiIrCJZB+3KzAFadpovL8XY0Ul/QRZiYoWpUYbwN8fpj9IJjHdivvSFHGjylwHezaceJiFVMwS8ekPAXaBUlEdHGr+m8zpOPcCBMuOes65J0Kb85dBt8uos2IX9iYUpUM67gGNLEAZU+oNXoFhN3HwKI7S39yNZBonVJGfpDT+1gL1UOays6MrRi+imY9mevPVFHFFMQIIGH3kn2hJ+X8pTRbveXY/8U/zm/qTNMNVQ5xBLm1goePGSySXTJfYjxtFsU+u/8FogOx1DiaTveVx3Y2XsF0dJmYZ32v5wDQSg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Tue, 23 Mar 2021 18:08:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 18:08:58 +0000
Date:   Tue, 23 Mar 2021 15:08:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: cm_process_routed_req() does not resonate well with RoCE systems
Message-ID: <20210323180856.GL2356281@nvidia.com>
References: <566B6781-C268-4B1C-A359-44B2FE14B91A@oracle.com>
 <D96DEBF5-042B-4B92-A512-EA6757020960@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D96DEBF5-042B-4B92-A512-EA6757020960@oracle.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BYAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:a02:a8::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 23 Mar 2021 18:08:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOlSa-001d9O-E1; Tue, 23 Mar 2021 15:08:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91be3519-09bd-49df-6a9a-08d8ee26baf3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:
X-Microsoft-Antispam-PRVS: <DM5PR12MB166004B380B4BE5B8FE44977C2649@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gP8zBZHZ1mbMYB4sfUgPxX6ou7rbRSeGyKHGgDanfVkIP5BFkZ5tqWnwYX62PtUV32mos8efCntD0nuvsZxytCXDPkfrRXrvlUL/pP8z13IvhaPXoJa8vr5OvfcWl8EsdetGWQ7jtp72Bp8msYPOcxhFGkZP+cgLpoMSE9729kUCrua8JKRLy60Tj87pJczoHr1e1GTL1PHeDZLaJu4kE+WZjMUUgDMgrIuT9ttmsjvylOf1m7/20gV3HR/J+SvN7YIRyYzEJG6P93NAMy6+t5xfV89+oSYA+Q0EIZa8fnqszyjLN6c+2bb9QRtsvGSBLuExf/f46E+c84TAn9K535SdIhIy7ygG+SB9rLUqiRMeAbOT7NqO5cvfJlyfmciX/iMQKHsldvH6eS8n0shb47LqHzHrjtKq2qBphaqzU83rS0M/6+N7QxlBUCjFXyiu9ddl0T7KqGItlknSQrH4aytHfBmnOcf8SB1htgLdiNAG4Cpvn+41KtXdqyPAxaR+5r38s4eUEpEC5ym0AJkmyS7b6MFsvMflAYpy4gKwJYuJQbik7w1Zm365+jmP85ImgFeY3CXwezonxsPimckSAGF/rfWcoBIQwj3p//cEvKuN074PyXr4bj7eqZl1yz4ReLWJHpX5pSU7Pnxn2kEl9S3aad3HyBzWo2dNPC1cpvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(33656002)(8936002)(66946007)(426003)(2616005)(9746002)(6916009)(478600001)(53546011)(66476007)(66556008)(9786002)(4326008)(26005)(5660300002)(83380400001)(38100700001)(54906003)(186003)(2906002)(86362001)(316002)(36756003)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G1lvQ084dAzVhhETUL7tVwZSx62pMdDUYSo/fy54enaYbnslBXwK9Of5IFvW?=
 =?us-ascii?Q?INb/DXE/B3sY1PjpYR/wFNVDVdkuOKaHt3yCmNl9fsfUum7lUfs4aeZ2UZ6V?=
 =?us-ascii?Q?m48JvBftCASZZEGO6XjdLlFn2uaA52zjokugLWJLcxUIP4T2G7bSWCkBfA+d?=
 =?us-ascii?Q?kJ7Aov5W7X57n29n6tX1HDLZeCP+Om7PeKKb8/HComUWtwsn9ug7KQnfZ8jo?=
 =?us-ascii?Q?zNC9fNa5bJhu0c9+6X5iXFBNV/inS/fhXCYwZgOUVwmIeMx6s5cXMuWS8kHI?=
 =?us-ascii?Q?tH3/BrA358R5HZpya8JjIcEnKvLxwNBSmUCkpzA1+8pQ2KIonqG+sYZwdWqE?=
 =?us-ascii?Q?CvsDPrXRZDbNtsMEAbWS1alUtPCszG1RAbt09voIc2fCwnplSL+h4gDqbfaL?=
 =?us-ascii?Q?hFNwPNk7Bz0thVxJH9yPsSLiHE679L6EarbT8PEVu7Ag9YWOzLJCEIDiEoTu?=
 =?us-ascii?Q?zbtFn9V8FrlgXXgQ+qwaIUb54+jIa96PzNzzquItx/pafAlFZ4NdlM61X4Ld?=
 =?us-ascii?Q?+avMg0foUMGePiweSI5UQr7zgG9L4/BDiN0yn9KJXmrtWbUxqCTotWsFw4mc?=
 =?us-ascii?Q?CkRyU0h4jp7KJvhlLWXuNTD0bBdWoG9m6pNBKmFe9zwhnKbshoFc6eU93kfz?=
 =?us-ascii?Q?BL2jGkIwCWncW/9RmeuE6DwdVPHLlPGvQzMR2e9E7Owl1HbnOcNxNCE/RyDv?=
 =?us-ascii?Q?NMGuhIyNrJxzdR3QU5x01qoQyQ6FIxT6xx7tbPrBzMEpEWl51xBqTRa5Wva8?=
 =?us-ascii?Q?viCo+JZmUUgnR6dvVI+NWCAEVsKQNEvRFATV9afJ1EZ/8VXvre0ekgH/wGDi?=
 =?us-ascii?Q?6rCNvxR8C7U4Y58dDvrhCmas72+DSx9kEgeQNQjfo3y0fo6y/m1LSOelni7W?=
 =?us-ascii?Q?ewU0VFsARscCkIw/3dwsRl9hymy5LrMt9uw8bVYcXHTMN7INTwzvLLKVrt+p?=
 =?us-ascii?Q?bgX10ilcfVhLJGcNbsf6W9sBeoN62movkEY2aLsF110ixGaDeeE90esV8vnf?=
 =?us-ascii?Q?kEKlXGd7yIW1O9k29tlDl/hUSVNlDFWWWFWPdbN2fa/VCDIPlL5w3+OhzzFr?=
 =?us-ascii?Q?Br+N64Usf//TP9e0s3Onovqj5T/Eao4+pUrNtyTjuR4J5/w1NGzAAooWzuoN?=
 =?us-ascii?Q?ghm6MlUQTX3JPDkffXgCPnQvH3nvAI3lkuypfKGjiWxuySd+wqmp8l4R0KSU?=
 =?us-ascii?Q?3hsxrkq333EAmAWPzT94U0RmogYB0CYDQjl7Zk1Co3IA4PA+31VWZe6SqHNE?=
 =?us-ascii?Q?177mrywbUTKfwQ8QoRNb0UB4qOq4n/j2yMwomWYu2ASFBcCi95kammCL5n+P?=
 =?us-ascii?Q?JC3IoqwAn9/5MYfkPZiuShHP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91be3519-09bd-49df-6a9a-08d8ee26baf3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 18:08:58.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OLXEcHWWvfFhpkqDgayVTYDtixnDirrh/tKqhRV0fxAI9ZtgzSQeLbf80UYV07Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 03:07:07PM +0000, Haakon Bugge wrote:
> 
> 
> > On 18 Mar 2021, at 20:21, Haakon Bugge <haakon.bugge@oracle.com> wrote:
> > 
> > With the introduction of RoCE systems, a CM REQ message will contain (pasted from Wireshark):
> > 
> > Primary Hop Limit: 0x40
> > .... 0... = Primary Subnet Local: 0x0
> > 
> > This because cma_resolve_iboe_route() has:
> > 
> >        if (((struct sockaddr *)&id_priv->id.route.addr.dst_addr)->sa_family != AF_IB)
> >                /* TODO: get the hoplimit from the inet/inet6 device */
> >                route->path_rec->hop_limit = addr->dev_addr.hoplimit;
> >        else
> >                route->path_rec->hop_limit = 1;
> > 
> > The addr->dev_addr.hoplimit is coming from addr4_resolve(), which has:
> > 
> > 	addr->hoplimit = ip4_dst_hoplimit(&rt->dst);
> > 
> > ip4_dst_hoplimit() returns the value of the sysctl net.ipv4.ip_default_ttl in this case (64).
> > 
> > For the purpose of this case, consider the CM REQ to have the Primary SL != 0.
> > 
> > When this REQ gets processed by cm_req_handler(), the cm_process_routed_req() function is called.
> > 
> > Since the Primary Subnet Local value is zero in the request, and since this is RoCE (Primary Local LID is permissive), the following statement will be executed:
> > 
> > 	IBA_SET(CM_REQ_PRIMARY_SL, req_msg, wc->sl);
> > 
> > At least on the system I ran on, which was equipped with a
> > Mellanox CX-5 HCA, the wc->sl is zero. Hence, the request to setup
> > a connection using an SL != zero, will not be honoured, and a
> > connection using SL zero will be created instead.
> > 
> > As a side note, in cm_process_routed_req(), we have:
> > 
> > 	IBA_SET(CM_REQ_PRIMARY_REMOTE_PORT_LID, req_msg, wc->dlid_path_bits);
> > 
> > which is strange, since a LID is 16 bits, whereas dlid_path_bits is only eight.
> > 
> > I am uncertain about the correct fix here. Any input appreciated.
> 
> I intend to send a patch doing:
> 
> +++ b/drivers/infiniband/core/cm.c
> @@ -2138,7 +2138,8 @@ static int cm_req_handler(struct cm_work *work)
>                 goto destroy;
>         }
>  
> -       cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
> +       if (cm_id_priv->av.ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE)
> +               cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
>  
>         memset(&work->path[0], 0, sizeof(work->path[0]));
>         if (cm_req_has_alt_path(req_msg))
> > 
> if I do not get a push back.

This does seem reasonable, but I don't understand the underlying
issue, why is anything in roce land touching the SL? Are you trying to
use the SL as a proxy for the TOS bits?

Jason
