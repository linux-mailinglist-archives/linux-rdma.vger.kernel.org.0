Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E8B534B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfIQQqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 12:46:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44915 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfIQQqY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 12:46:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so2476611pfn.11;
        Tue, 17 Sep 2019 09:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fag6AbAhcwaT94lWQV+WjIWSbgvmY4AHwJNmqtlepJg=;
        b=btOiS7um9A9lqe1AGEMsfoutcqBmL88carU+BDCjI6olkuz8qpSv3RjiMuaSyXOuRF
         wKGoznKnzVfIB9a5KaL+4h8aqANHhctMTj0KcL76PfEM4ml1dKHGm0NTeLQSlQc3X7Wx
         mLUT5sIcrDZVi/regjvgqYRjYCN/aapOkVDrc+yo1R3kbefFvQ9rKPuCNgJ+L3sTBYtc
         z9uycWhAh4EYqq1atu6gu5j+OHR2oloLehQ6MLRc8sXgUlqKaltNxb0M6mHAJlP5bGfp
         hR+HzNhVdBPw6Rv0TJojyDMkTDdZb3XcmnBRYTPzBRFDDJbN0p9Iau0lEpv/rY22BN2K
         MyvQ==
X-Gm-Message-State: APjAAAVB3hITexpUb4hwKv3d63G6HLzQT3JQrIe9dlhNSShUnGYOFfKE
        HYq1fdv4PbqrGYI71cZjV90=
X-Google-Smtp-Source: APXvYqxEmkhtIjgKugCNlK5OAxfzKY0fhPLBzOyPpARWcWeRjhiaqrpx3D0qfEV1ivPocR+lDGcWQA==
X-Received: by 2002:a17:90a:b78c:: with SMTP id m12mr5982904pjr.143.1568738783393;
        Tue, 17 Sep 2019 09:46:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 69sm3910823pfb.145.2019.09.17.09.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:46:22 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
 <CAMGffEn6=P8bLi7SyUC19+7wbU6YEZ_5BqjR06+CBKvENw-tFg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5a14b67d-9e32-c599-6525-7564becd526a@acm.org>
Date:   Tue, 17 Sep 2019 09:46:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEn6=P8bLi7SyUC19+7wbU6YEZ_5BqjR06+CBKvENw-tFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/17/19 6:09 AM, Jinpu Wang wrote:
>>> +static void ibnbd_softirq_done_fn(struct request *rq)
>>> +{
>>> +     struct ibnbd_clt_dev *dev       = rq->rq_disk->private_data;
>>> +     struct ibnbd_clt_session *sess  = dev->sess;
>>> +     struct ibnbd_iu *iu;
>>> +
>>> +     iu = blk_mq_rq_to_pdu(rq);
>>> +     ibnbd_put_tag(sess, iu->tag);
>>> +     blk_mq_end_request(rq, iu->status);
>>> +}
>>> +
>>> +static void msg_io_conf(void *priv, int errno)
>>> +{
>>> +     struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;
>>> +     struct ibnbd_clt_dev *dev = iu->dev;
>>> +     struct request *rq = iu->rq;
>>> +
>>> +     iu->status = errno ? BLK_STS_IOERR : BLK_STS_OK;
>>> +
>>> +     if (softirq_enable) {
>>> +             blk_mq_complete_request(rq);
>>> +     } else {
>>> +             ibnbd_put_tag(dev->sess, iu->tag);
>>> +             blk_mq_end_request(rq, iu->status);
>>> +     }
>>
>> Block drivers must call blk_mq_complete_request() instead of
>> blk_mq_end_request() to complete a request after processing of the
>> request has been started. Calling blk_mq_end_request() to complete a
>> request is racy in case a timeout occurs while blk_mq_end_request() is
>> in progress.
> 
> Could you elaborate a bit more, blk_mq_end_request is exported function and
> used by a lot of block drivers: scsi, dm, etc.
> Is there an open bug report for the problem?

Hi Jinpu,

There is only one blk_mq_end_request() call in the SCSI code and it's 
inside the FC timeout handler (fc_bsg_job_timeout()). Calling 
blk_mq_end_request() from inside a timeout handler is fine but not to 
report to the block layer that a request has completed from outside the 
timeout handler after a request has started.

The device mapper calls blk_mq_complete_request() to report request 
completion to the block layer. See also dm_complete_request(). 
blk_mq_end_request() is only called by the device mapper from inside 
dm_softirq_done(). That last function is called from inside 
blk_mq_complete_request() and is not called directly.

The NVMe PCIe driver only calls blk_mq_end_request() from inside 
nvme_complete_rq(). nvme_complete_rq() is called by the PCIe driver from 
inside nvme_pci_complete_rq() and that last function is called from 
inside blk_mq_complete_request().

In other words, the SCSI core, the device mapper and the NVMe PCIe 
driver all use blk_mq_complete_request() to report request completion to 
the block layer from outside timeout handlers after a request has been 
started.

This is not a new requirement. I think that the legacy block layer 
equivalent, blk_complete_request(), was introduced in 2006 and that 
since then block drivers are required to call blk_complete_request() to 
report completion of requests from outside a timeout handler after these 
have been started.

Bart.
