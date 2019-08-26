Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4169CD0A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 12:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfHZKHM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 06:07:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58984 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbfHZKHM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 06:07:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QA3mM5131831;
        Mon, 26 Aug 2019 10:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=NlXJU3GNr55UXcGTgQW5puXibfQGU+3gGTXsTg7Yy/U=;
 b=FI3YwO+SmIeIaXRqAgsrlCwsXOM7BUydBucwFsn2Qui3NYuBHl4vULbjA5NO+uW8xOHw
 DGCddDN2EfdOTmj+zz67PoA6Hg5/hLcCxa/kmQJXB9BG3cMdtH98YZM8uTurHXn3fAum
 35jpXBr1ftqtT56fTgz/v+j7y1QaZ2tatTI4kJ418b6m92q0cn5Gt7eUUJfFPRepglK/
 rfEuLFw21lcuApPDSXYz6c05eofHjqWrMnNPKwAY46CG7hCHOpJoqJ5e79UFSF1R4Fcq
 yHWn1kN8XXAv3S3nZO76r9FNRcrroL+CyB+BAN2DlJa8UtHmON93iWS2fQIpNTZAevJn Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ujw7180kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 10:04:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QA3bvA056099;
        Mon, 26 Aug 2019 10:04:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ujw6hkygu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 10:04:49 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7QA4lnw019494;
        Mon, 26 Aug 2019 10:04:47 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 03:04:47 -0700
Date:   Mon, 26 Aug 2019 13:04:39 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190826100438.GD3698@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260112
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> 
> > - What mechanism takes care of the destruction of such objects (SCM_RIGHTS
> >   takes care for the ref counting of the context but i'm referring to the
> >   PDs and MRs objects)?
> 
> This is inherent in the lifetime of the uverbs file object to which cloned FDs
> (one in each process) have a reference to.
> 
> Add to your list "how does destruction of a MR in 1 process get communicated to
> the other?"  Does the 2nd process just get failed WR's?

I meant the opposite, i.e. when two processes are sharing an object, the
fact that one decides to destroy it cannot affect the other so a ref count
needs to be maintained so object will be disposed only in case of all
references asked for destruction.

> 
