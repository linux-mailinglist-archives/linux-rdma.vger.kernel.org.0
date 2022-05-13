Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE80526314
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiEMNjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381094AbiEMNb3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 09:31:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E15DA71
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 06:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyW3M9G8MWtaMqP6lTFejLx311T4P967yZeldWchAmiC40ozZNUuztL6oWH5xU82NtipXSSjQF0wteOs//ZQd1oNjlV85jMxraxwKeRbGKmtbBtIjHVQf/nKzeWV6BBhBfS1sJwNdhqLwbLt5mNtDoiU45nLmcCXuyf+GNufw9ES1PZA34YAtXl/A+zC4Pc5dR01cfRhtfkwpP6+jGyWMicvQAjG285nlsFAVZrWfoUGjcpMGb1tun4BNicHypGhj0835wMSU6wjt4JzJWliz9Xz4upiCSWSrLQxi57ELz254OqJs/S2fmaJkYvAHr3rNoEqpQ/ydQl/et3ESndQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk3lsVWV9R3TwAouD+e+LAql870cEzhJ4N//ALukgE8=;
 b=Bna1MD5A7bt1AD0Ppw7LYSjXvF4AGTfM3+71w6N2zCqUbOjdgkVq6o3z9o5lQm0CL/8Kx0v+W7wxgT8G072bcwmdkSsdCxijmS+1cBTfSD4B5jS+UbR7khgmQTBjQRQskt7esxRMAdAtB0AKCtnZvXyaJAJDiCuGkLjJbrUkt2utBiGIgDBXhBR7g3ov2QSMXsDUvQa85fwHZR/OKcZwsJI9kh0ZfyfZtwX1J+0HkAoysRylbPwyQq7UO0iSLeNH1FHrW0SyaUd8bP3y8HfoEBDquXS1p7+FYVh33v9T4NFjcIUbhaBP9yztPu8qYCThfv1Z7YCzbKiyJgjaAgS8Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DM6PR01MB5881.prod.exchangelabs.com (2603:10b6:5:203::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Fri, 13 May 2022 13:31:25 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b%7]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 13:31:25 +0000
Message-ID: <3c154d9a-bb9e-b237-3a4f-a4d5b2137bbf@talpey.com>
Date:   Fri, 13 May 2022 09:31:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] Adding private data and private data len as argument to
 rdma_disconnect()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Anand Ashok Khoje <anand.a.khoje@oracle.com>,
        Linux RDMA <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
References: <057cdabf-997b-6f4a-6877-0be89254166b@oracle.com>
 <22a2ee27-fe80-fc64-6838-0dd272288c46@oracle.com>
 <BYAPR15MB26310745FFF0D04D6E73822199CA9@BYAPR15MB2631.namprd15.prod.outlook.com>
 <20220513124601.GD63055@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20220513124601.GD63055@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4301ed7f-7b02-45dc-fe5b-08da34e4e0eb
X-MS-TrafficTypeDiagnostic: DM6PR01MB5881:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB5881C079BE38AA9315CE8DD9D6CA9@DM6PR01MB5881.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOyCmMjjtOtVoRbDL6IAqRy4aYzNOZ8vfAliVouyz5l3YjfMyKDVFCuNP5dQ5oM4c55+2q8+F6ZURQEuv7oI6RJpMkFw7xvx4CKw7J1RAIl13jt5i1FSkRV7ZDdJZ0A9fPoIa4ZVQs/gx38yxL2ghS3tl6uet8ghL7h1c5ITzyIp3e0ldEKqH1TMPIamIX0r150abyKTytdSZA1rSBpZ5uycq8c0J/raLf4Dt5Ru7LvfBTNr7HQjmix7ksAMe97+4oMpD7BzqMBvjSB6u3kQkdjp4ac5gnlJszsiDzlhpZf3QqKgo/f3tx6FEaQpU3V6FlH3QbaMBsWRlS/ApIHHIxu36GRGxGfJNYcLz49bSDFQxVRNEPyxoW+KsxlYSWsa+zcALjiDAzzOFlgUtaSuEjIO/1uKShvOo4nptK4IzKjgXTD2QIAwoacpKSuIrV3taDTxKlfED6Md0FDWzyS+inrwObPvzdAn5Q0vRpqYBU452ts8c1ZLnZeNe12HojJtaZpAgwW1iXt3+VouULpPpFEVp6O8TgntqPJW1nRAXjBlq0xAS0o6Y024q1/E4UOAxGItoEoF6EnqrhQ1XRaam2i0mBYIqEk3TB9CI+OL/RW3+wfO7snsdGIC50NFLmhCEYl9kiccdxwr2SqHht7NaRsKlLOfg9YfK1VHoImouR6XB5UwjgX/WxapOLJxOmEZX15Rzc0gvgYYVzFsZFP7bMly77FTJ9rMPiEb2AdBauPlMIyAcbZ40VvZWZw+FrNVklZSrNQE/ze7T57ySw8H/GqV4IiaL8w5kGB6QCxnorbYnhyADtcGO6r+MYLT49aE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(366004)(136003)(376002)(39830400003)(396003)(53546011)(38350700002)(86362001)(83380400001)(6512007)(26005)(31696002)(186003)(2616005)(8936002)(31686004)(66556008)(316002)(66476007)(8676002)(66946007)(36756003)(4326008)(38100700002)(5660300002)(508600001)(2906002)(54906003)(110136005)(6506007)(6486002)(966005)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R201WEgzNkduUVZxVnNqd2liZ0hQOEFSUXBkMnZDcE5TMkJOTmF3aEl4TTVF?=
 =?utf-8?B?WUtEblpMUUpyUU40aEYyRDdRNlBOWjdZdm9kT1pwbGxRbXU5cCsxb0xZVHp2?=
 =?utf-8?B?Q2FDT21IMzNzQmVBOWRkZk42TnBzeXdtd24vVmN4RlhNL1IyeEZFZ2pBZFY4?=
 =?utf-8?B?UStuTU81d1R5ejFiejVOekl6V2NUMWpDRlR2bEMyS2xrMXJralZQZW5hS0lY?=
 =?utf-8?B?V2JVb0dtenVZNHF5SGdvVjBtUXN2WDl5anZ1MXlsSjZGeGQrTnVRZnNhckVa?=
 =?utf-8?B?UXUzNEtSdTFLcTBzMjRrRC90aGVLbGZ3RnV6NzNzb2lzOEpnQkVaODZDRmF2?=
 =?utf-8?B?MTdDQi80Ymkyb05NdDRlN2hjRnJjVGgzTjhBMlFWd1pqcVBBTEhldkJoV0o1?=
 =?utf-8?B?QWlKQVlHQjkwM2RxbHNWdG9rT1k1R2VNeDRvOXhTQ0kyVFZacmdLdFEwRXRH?=
 =?utf-8?B?M0dUc0UvTWQrTlk2UjRicEs1cnlITGNJVlRVS1h0aG9iaE4yZm9PZFlrUWJP?=
 =?utf-8?B?SjJHTGlKb0tQN0QrM25OdzFERWo3Und5dE9zZGlNNDYzYWNiZmM3TTFHSmlr?=
 =?utf-8?B?S1RyOCtVMTNzZDNRYmV3c0svOUs2ZWpEcEFCaHp1Qk5jSzBXTW1wSkJBOWsz?=
 =?utf-8?B?WUFJUFp6S3FaOXU1MkNXRkRyT0owT25JcU53K2ZhNUJtb2tTRnRaTTVIOURP?=
 =?utf-8?B?cVluSlVkck5KaEMrd3dHdFpUeHdVQmNkUGJQMEJYVU5haWQ0d0ZuNGNYdnlU?=
 =?utf-8?B?MEQvYkI5bVo4dmtuekxySURFc3VXN1IrWkFhT3dlQnRZbGMway9NZFRlV1JM?=
 =?utf-8?B?S3dNWFdRRVhRQ0hqYjYzL29ub1VldFBpNURJbk56NFU1c0JuanpYdUdrMW1y?=
 =?utf-8?B?Tjkwa095NVlKMHFBQ2k5enRnQ0FxYmlhV3JiUmRjeG4vaElsSWp2eW9makZw?=
 =?utf-8?B?NlZua2lkZW1WQy9zbDkxUlFIT3FwS3d4OEloVGt3RmFVREJLTDlQV04zZC9l?=
 =?utf-8?B?U1JFY2lwcTNoT0ZqNFVKSlZpM2M1MG14L0NCa3loOTMycjA3WUlTaFh3MXhV?=
 =?utf-8?B?a1VaSGhZbjJYMzVBekxudHNoaCtDNHVvZDdnY0hJZzJIaWN0RkJMQ1lUd3Rp?=
 =?utf-8?B?Nk0yV2g0VlNjdEY1U2xGVkN5OGxXODlFL3dGSUtLWllYcTRUQVgxWTMvT1FB?=
 =?utf-8?B?NlJCN2JZZVFBb2FDYTg4ZWJxU0JaSWQyVHpIbURWZVZkWTZ0TThxYm5sSXVE?=
 =?utf-8?B?bUQrT2VyWXVVR1ZjMXlKRFhKSjRJRktCa29ieGJ1SWNxWlFSa203MkFZTGdP?=
 =?utf-8?B?cUZaLzM5UWU5dUZCaWZtYnNydE9Cb1FSbjdJZjVQQ0RmSnd4dVd3VGhFVDZY?=
 =?utf-8?B?OFk4Q29ha1hiVEFaL2dRd29MWWYrQ1VFT1RtcE1nZFliekYwa2h5M2FCZEly?=
 =?utf-8?B?NGQ3dkdsYWtBdDNzdDZHb2tmNkxsK05ZTEs4aXJKR05sMk1oK2pPbVUzaDlp?=
 =?utf-8?B?ZnF5cVlqZnZTUzJRamIvRzVXaGFiS05wRXM1bExYc1pRcEdZam5UNEVucVdW?=
 =?utf-8?B?SGY5bnRGWTFNL1o5MWhOOXpGY1pqWUZia2t3UHpQN1lmdlRNZDQ4L1dOUm5R?=
 =?utf-8?B?dWdiWERuN2ZzcVIrSEtQYmYvSHNaY0ptOTlIYUJxWDVTSFAvL1ZhOFJXc1Z0?=
 =?utf-8?B?QThOUm54eDhCb0lBUjdtR3dOcmZ5VDdZbFdJNzFTV2U5YkFKUm9pSk5JOGph?=
 =?utf-8?B?N0JRVGVLek43aWxJeHByNXg3MXl4eWpaZDhtQW0rejB5RWpmbEdSeFYzb0hB?=
 =?utf-8?B?YW5hTUs0c1Y2cm00S2habmE3S2RxUkRRU2g5NG8zOXJKdEw2ZkJmUThLQmFF?=
 =?utf-8?B?K3YzcllKUW93clZSd2tDR1pnc2NjaFM2RzVxc0pnQTZ4ZkgwcXcyL2RxWlB0?=
 =?utf-8?B?d0VFQTJOUFdibXZSRGVmZjhmVjRiVmx5QUIzZ1dtYllqSU5kVHJVdjNyMkQv?=
 =?utf-8?B?bG9RKzlGN2t5Wlo5WnU2c05wcy9LcnY5WTdXRU5ZY1lIZ2xoUEg2OUs0bVFX?=
 =?utf-8?B?ZHR2WXRIUkFMR3UxYk1qV1NkVW1abG5jUFVHM0tGc2dIc0k2bWZOeVlVSzdn?=
 =?utf-8?B?S2VoSmlWa1BMNzBPRWZpeVJBUmNKNVNJdG42cmRuMGRLNXhtaTA0VytZdFp2?=
 =?utf-8?B?V3pIREZwbWpQQW5McDhkREVkMDdEN0hLc1pDTkhkSEtlSFBpZXk0MGxWYmM0?=
 =?utf-8?B?aGs4WHJBNndhTUx3eDhDdGdzU1ZnODRyM3JSWjd0V2hlWktuazFkdEJZRU1M?=
 =?utf-8?Q?nZJ2+XNyz455pdJyBd?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4301ed7f-7b02-45dc-fe5b-08da34e4e0eb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 13:31:25.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg+qNcb2V8nCGwXkvk/QyoPZC6VbnA+q1IeEPVeuWZI10jPgawP5LDwqmKDi0zVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5881
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/2022 8:46 AM, Jason Gunthorpe wrote:
> On Fri, May 13, 2022 at 09:39:44AM +0000, Bernard Metzler wrote:
> 
>> Not all providers support the transfer of private data in control
>> messages after connection establishment -
>> rdma_reject()/rdma_accept() being the last opportunity to send
>> private data in connections lifetime for e.g.  iWarp
>> connections. Maybe that is why it is not exposed at the disconnect
>> API call? Would RoCE support it?
> 
> RoCE and IB have a place to put it, IB does not.

I think you meant "iWARP does not", but that's partially incorrect.
The Terminate message in iWARP carries a payload which is provided
by the layer which caused the termination.

The "layer" 4-bit field and RDMA/DDP/LLP ETypes in:
   https://datatracker.ietf.org/doc/html/rfc5040#section-4.8

It has been discussed before to add additional values to iWARP,
to carry exactly this kind of "syndrome" data. The discussion
could certainly be had again!

> The lack of support in iWarp is problematic, these APIs are supposed
> to be fairly high level things.

Right. Especially we do not want to define a "protocol-in-protocol"
which allows arbitary data to be exchanged here. It needs an
interoperable, and testable, specification. For all RDMA protocols,
which all ULPs can rely on.

> We clearly can't just extend the existing rdma_disconnect() due to
> this, and some kind of negotiation would be needed so the ULP can
> learn if the extra data is supported at all.

Yep.

Tom.

> 
> Jason
> 
