Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBAA09CBD4
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfHZInh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 26 Aug 2019 04:43:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3951 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbfHZInh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 04:43:37 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id E7AE158D2314C111FE6E;
        Mon, 26 Aug 2019 16:43:34 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 26 Aug 2019 16:43:34 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.69]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0439.000;
 Mon, 26 Aug 2019 16:43:24 +0800
From:   liweihang <liweihang@hisilicon.com>
To:     Leon Romanovsky <leon@kernel.org>, oulijun <oulijun@huawei.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH for-next 1/9] RDMA/hns: Refactor cmd init and mode
        selection for hip08
Thread-Topic: [PATCH for-next 1/9] RDMA/hns: Refactor cmd init and mode
        selection for hip08
Thread-Index: AQHVWES2z/H3yppXpk+S7enpXbi+lqcNHyDQ
Date:   Mon, 26 Aug 2019 08:43:25 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0203B3B7@DGGEML522-MBX.china.huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
        <1566393276-42555-2-git-send-email-oulijun@huawei.com>
 <20190821171928.GB27741@mtr-leonro.mtl.com>
In-Reply-To: <20190821171928.GB27741@mtr-leonro.mtl.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of Leon
> Romanovsky
> Sent: Thursday, August 22, 2019 1:19 AM
> To: oulijun <oulijun@huawei.com>
> Cc: linux-rdma@vger.kernel.org; jgg@ziepe.ca; dledford@redhat.com;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH for-next 1/9] RDMA/hns: Refactor cmd init and mode
> selection for hip08
> 
> On Wed, Aug 21, 2019 at 09:14:28PM +0800, Lijun Ou wrote:
> > From: Yixian Liu <liuyixian@huawei.com>
> >
> > This patch refactor the initialization of cmd, and also for the cmd
> > mode selection on event and poll mode.
> >
> > Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> > Signed-off-by: Lang Chen <chenglang@huawei.com>
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_cmd.c  | 14 ++++----------
> > drivers/infiniband/hw/hns/hns_roce_main.c | 18 ++++++++----------
> >  2 files changed, 12 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c
> > b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> > index ade26fa..547002f 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> > @@ -251,23 +251,17 @@ int hns_roce_cmd_use_events(struct
> hns_roce_dev *hr_dev)
> >  	hr_cmd->token_mask = CMD_TOKEN_MASK;
> >  	hr_cmd->use_events = 1;
> >
> > -	down(&hr_cmd->poll_sem);
> > -
> >  	return 0;
> >  }
> >
> >  void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)  {
> >  	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
> > -	int i;
> > -
> > -	hr_cmd->use_events = 0;
> >
> > -	for (i = 0; i < hr_cmd->max_cmds; ++i)
> > -		down(&hr_cmd->event_sem);
> > -
> > -	kfree(hr_cmd->context);
> > -	up(&hr_cmd->poll_sem);
> > +	if (hr_cmd->use_events) {
> 
> Ensure that hr_cmd->context == NULL in places where it shouldn't be kfreed
> and remove this "if (hr_cmd->use_events)".
> 
> Thanks
> .

Hi Leon,

Thanks for your advice, will remove above judgement in v2.

> 
> 
> > +		kfree(hr_cmd->context);
> > +		hr_cmd->use_events = 0;
> > +	}
> >  }
> >
> >  struct hns_roce_cmd_mailbox
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c
> > b/drivers/infiniband/hw/hns/hns_roce_main.c
> > index 1b757cc..f3b2f67 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> > @@ -902,6 +902,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
> >  		goto error_failed_cmd_init;
> >  	}
> >
> > +	/* EQ depends on poll mode, event mode depends on EQ */
> >  	ret = hr_dev->hw->init_eq(hr_dev);
> >  	if (ret) {
> >  		dev_err(dev, "eq init failed!\n");
> > @@ -911,8 +912,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
> >  	if (hr_dev->cmd_mod) {
> >  		ret = hns_roce_cmd_use_events(hr_dev);
> >  		if (ret) {
> > -			dev_err(dev, "Switch to event-driven cmd failed!\n");
> > -			goto error_failed_use_event;
> > +			dev_warn(dev,
> > +				 "Cmd event  mode failed, set back to
> poll!\n");
> > +			hns_roce_cmd_use_polling(hr_dev);
> >  		}
> >  	}
> >
> > @@ -928,12 +930,10 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
> >  		goto error_failed_setup_hca;
> >  	}
> >
> > -	if (hr_dev->hw->hw_init) {
> > -		ret = hr_dev->hw->hw_init(hr_dev);
> > -		if (ret) {
> > -			dev_err(dev, "hw_init failed!\n");
> > -			goto error_failed_engine_init;
> > -		}
> > +	ret = hr_dev->hw->hw_init(hr_dev);
> > +	if (ret) {
> > +		dev_err(dev, "hw_init failed!\n");
> > +		goto error_failed_engine_init;
> >  	}
> >
> >  	ret = hns_roce_register_device(hr_dev); @@ -955,8 +955,6 @@ int
> > hns_roce_init(struct hns_roce_dev *hr_dev)
> >  error_failed_init_hem:
> >  	if (hr_dev->cmd_mod)
> >  		hns_roce_cmd_use_polling(hr_dev);
> > -
> > -error_failed_use_event:
> >  	hr_dev->hw->cleanup_eq(hr_dev);
> >
> >  error_failed_eq_table:
> > --
> > 2.8.1
> >
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
