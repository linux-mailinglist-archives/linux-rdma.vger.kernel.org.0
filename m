Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923F84DE0E0
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiCRSUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbiCRSUP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 14:20:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B272EDC18
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:18:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id i8so7467753qtx.6
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8HoSWIdlDqfILUtjYnlFYjmaUs7eHNmZXLlZo/vNMqs=;
        b=G6lrmPH6u71jq1NzA/bNPIFhI3uxwmnn3vNQX2MdXo6w48VMIOa5sj0+YRZ9gJeac2
         bRXaJVJlKjWlqlbIPAXlfQhZydrNCU3idd5aHXyLxyKDgrCwGdPwrZu3S1iOc+PVwy8P
         JRXLXVGkYNEyBzoTj7aTv0Ecqhsk+hBsuIFtZpVKeDlvhhtM/hozTw+WYC2bQMS2ML6a
         GLKuHqblVWnSTKuVzyT7EgaE6uhCV1dCuPzxT7pDAOJNCfrKs1XvGUNzatSvTGnoF7h1
         0b+SKXkF8NY1dHtfaF5OYO5cfhV9qACVxYWFTtlNWzgK7hXSKzSQoJbSiVhuqxe0SV0J
         j0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HoSWIdlDqfILUtjYnlFYjmaUs7eHNmZXLlZo/vNMqs=;
        b=qXDp8/pVXePogXP/wgeAjdlq0+U5ItV97+3w7aDbpJVWTU+qlpl4bV2chuQuAflaDZ
         0k61MhV2LxN8dGGT3ZS9haub3/v/yvsYx3tkbFq5NhWs/4vaSBysQhM6pjBOKsompBPB
         ZX3+sSKJdFuF9J1Yyp1OJa6JJ8s6/51CQJ+T2ri1xeGWgxxJSUxD3CpelBB+5O416H0t
         PjoDRqP+sqjjkM1mWXqk0Qgu09kaeERhqsIZjF1BtgTyRdVJpthSWX7IxBtJmLYV/SsM
         BqDMSws79wKtMH0t0L0J8mkXbjC0IPgyAWL+FdsPJ+jQOwUkMCPw5MlCIeZI5R7uXeip
         FzzA==
X-Gm-Message-State: AOAM532WnYWoMfC+fo15GpxN3l0YpZAnTGVPcGKi+yVcloPEpVOsd/us
        kR7Ump7D/FGj0Tz+sgOYM39v4uMKazU8wA==
X-Google-Smtp-Source: ABdhPJxM1seXCrcounB+M8XqP6SEH6MMVyuICHj9LPz885GDr9bCMGJDSqp5VTxBt+by45vzxu5pvA==
X-Received: by 2002:a05:622a:105:b0:2e1:d653:c325 with SMTP id u5-20020a05622a010500b002e1d653c325mr8255356qtw.75.1647627531933;
        Fri, 18 Mar 2022 11:18:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a0ce100b0067e0cd1746fsm3955258qkj.51.2022.03.18.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:18:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nVHBa-002ldJ-Q7; Fri, 18 Mar 2022 15:18:50 -0300
Date:   Fri, 18 Mar 2022 15:18:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, dledford@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v4 06/12] RDMA/erdma: Add event queue
 implementation
Message-ID: <20220318181850.GG64706@ziepe.ca>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-7-chengyou@linux.alibaba.com>
 <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 18, 2022 at 07:43:21PM +0800, Wenpeng Liang wrote:

> > +static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
> > +{
> > +	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
> > +	cpumask_t affinity_hint_mask;
> > +	u32 cpu;
> > +	int err;
> > +
> > +	snprintf(eqc->irq_name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
> > +		ceqn, pci_name(dev->pdev));
> 
> Parameters in parentheses are not vertically aligned, a space is missing before "ceqn".

Generally I will recommend such a large amount of code be run through
clang-format and the good things it changes be merged. Most of what it
suggests is good kernel style

Jason
