Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0A79CB2F
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfHZIAt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 26 Aug 2019 04:00:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbfHZIAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 04:00:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7Q7sxgb106403
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 04:00:47 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umbbj0ht6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 04:00:47 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 26 Aug 2019 08:00:46 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 26 Aug 2019 08:00:42 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019082608004186-178688 ;
          Mon, 26 Aug 2019 08:00:41 +0000 
In-Reply-To: <6ed77231-800b-f629-5d15-14409f0777c7@acm.org>
Subject: Re: siw trigger BUG: sleeping function called from invalid context at
 mm/slab.h:50
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 26 Aug 2019 08:00:42 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <6ed77231-800b-f629-5d15-14409f0777c7@acm.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 41579
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082608-8889-0000-0000-00000038C9D0
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000077
X-IBM-SpamModules-Versions: BY=3.00011657; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01252255; UDB=6.00661296; IPR=6.01033847;
 MB=3.00028335; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-26 08:00:44
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-26 05:12:12 - 6.00010331
x-cbparentid: 19082608-8890-0000-0000-00000052D508
Message-Id: <OFF0E427F2.51415251-ON00258462.002C0261-00258462.002C0268@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bart Van Assche" <bvanassche@acm.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>,
>linux-rdma@vger.kernel.org
>From: "Bart Van Assche" <bvanassche@acm.org>
>Date: 08/24/2019 01:02AM
>Subject: [EXTERNAL] siw trigger BUG: sleeping function called from
>invalid context at mm/slab.h:50
>
>Hi Bernard,
>
>If I try to associate the ib_srpt driver with the siw driver the
>complaint shown below appears on the console. In iw_cm_listen() I
>found the following:
>
>         [ ... ]
>	spin_lock_irqsave(&cm_id_priv->lock, flags);
>	switch (cm_id_priv->state) {
>	case IW_CM_STATE_IDLE:
>		cm_id_priv->state = IW_CM_STATE_LISTEN;
>		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>		ret = iw_cm_map(cm_id, false);
>		if (!ret)
>			ret = cm_id->device->ops.iw_create_listen(cm_id,
>								  backlog);
>		if (ret)
>			cm_id_priv->state = IW_CM_STATE_IDLE;
>		spin_lock_irqsave(&cm_id_priv->lock, flags);
>		break;
>	default:
>		ret = -EINVAL;
>	}
>	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>         [ ... ]
>
>So it surprises me that siw_listen_address() calls a function that
>can sleep. Do you think this is a correct analysis of the call trace
>shown below?
>

Hi Bart,

Yes, this is a BUG. Thanks very much for spotting it!
Obviously, there is not similar thing for ipv6 like
'in_dev_for_each_ifa_rtnl()'. Let me think about a
good fix to that and come back asap.

Many thanks!
Bernard.


