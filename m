Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9998A1744EC
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Feb 2020 05:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB2Ety (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 23:49:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53282 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2Ety (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 23:49:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01T4nSa0034340;
        Sat, 29 Feb 2020 04:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=kzR9CGwA8QkKF16UH73eDglqPnsxYFUS7yPTFc3wG+Q=;
 b=sQsrTyp0UNryUPYAH0iLRkB3zVXKd7jPvMwzMVe36OFfS3fsDIZ+xOBrl+WYdVYp51Wh
 y1QEFQsQKduAvIvwJMr98eRx669obe6EB/hTtBE0ohnZMMYASxaVYzI0PAh16VbjV0P7
 csbeDl3dD7+ZcEKi+ZhCo3v3h8aKVeqmdvi0JXipoqK6HX2WYrEcHP9mW72Hps9osHfR
 foVgPY99mteM6Ewzcm25KOoc0fJh+1NCrWcDGc6eJ+smX55mxgRiDrFMxEr4d2984wA5
 OjcpgBysDn/TA5dLsa2zlFIF99b7saDyvFQHX+qrOALUZv7+mjYHlWx/clW0C5oHq+V3 Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yffwq8404-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 04:49:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01T4lhd2010921;
        Sat, 29 Feb 2020 04:49:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yfe0d9c8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 04:49:27 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01T4nPYo013441;
        Sat, 29 Feb 2020 04:49:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 20:49:24 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, open-iscsi@googlegroups.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] scsi: Replace zero-length array with flexible-array member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200224161406.GA21454@embeddedor>
Date:   Fri, 28 Feb 2020 23:49:21 -0500
In-Reply-To: <20200224161406.GA21454@embeddedor> (Gustavo A. R. Silva's
        message of "Mon, 24 Feb 2020 10:14:06 -0600")
Message-ID: <yq1eeue5772.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=619 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002290033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=685 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002290033
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Gustavo,

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array
> member[1][2], introduced in C99:

Applied to 5.7/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
