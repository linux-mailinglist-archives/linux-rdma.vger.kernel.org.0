Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCDB1235C2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2019 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLQTds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Dec 2019 14:33:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37978 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfLQTds (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Dec 2019 14:33:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so8108429pfc.5;
        Tue, 17 Dec 2019 11:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sphtT1DtfRV6nmsmhC84wFhknw0860VVLYEGqnAn6m0=;
        b=ERGG9hkhAWHsxvfxy9D5Dgz32TJ9iM8NazaXyYg0KAx9s9d2XGDRevPeoT5XaFWyLj
         jPo4k8NfTUWUNv5qQ5L/rE3NCihoMvDgHLfdgVYbEcvqcuhrqXHqL37yp6g/igCD1Dea
         CU/5SBR5mXgtbBMBTeDAbaCgMJvqquZF6XUDTOpRitQZouw2V+MaOhD85OVyUP+vN1jX
         WZhcHiSi8Y1rkyUlxb7+ZiTcl978/8tHuG3f4Yvye8zD59MRXq38evZE8waHsDbU6maP
         QKx8j7gonzJPabL9WgR0/EkcVUcGpV6gCc+VCm8xcm9tN7ZsGw0DuW/FZ6hc87t92Yld
         fPyw==
X-Gm-Message-State: APjAAAWF3AcoNa6CXraZzFTnOajfaU5qcPGQiYJdEoBsjygvki5lsLze
        POwLnG4R6/Wci3h3Wu55F7xPEX/l
X-Google-Smtp-Source: APXvYqzR+b8On1Qg5pUAGdjkD+LGiI3BORdnzprcEqc2o0S8ib/TTq3QFPYfRD3kRbSPxMLYBvUKcw==
X-Received: by 2002:a63:5a26:: with SMTP id o38mr26391027pgb.273.1576611227420;
        Tue, 17 Dec 2019 11:33:47 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b190sm27601882pfg.66.2019.12.17.11.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:33:46 -0800 (PST)
Subject: Re: [PATCH] scsi: RDMA/srpt: Fix incorrect pointer dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191217192649.24212-1-pakki001@umn.edu>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4103701f-27f0-f856-7aae-97420b8236d2@acm.org>
Date:   Tue, 17 Dec 2019 11:33:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217192649.24212-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/17/19 11:26 AM, Aditya Pakki wrote:
> In srpt_queue_response(), the rdma channel ch is first
> dereferenced and then checked for NULL. This renders the
> assertion ineffective. This patch removes the assertion and
> avoids potential NULL pointer dereference.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 23c782e3d49a..bbc6729c81c0 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2803,15 +2803,17 @@ static void srpt_queue_response(struct se_cmd *cmd)
>   	struct srpt_send_ioctx *ioctx =
>   		container_of(cmd, struct srpt_send_ioctx, cmd);
>   	struct srpt_rdma_ch *ch = ioctx->ch;
> -	struct srpt_device *sdev = ch->sport->sdev;
>   	struct ib_send_wr send_wr, *first_wr = &send_wr;
> -	struct ib_sge sge;
>   	enum srpt_command_state state;
> +	struct srpt_device *sdev;
>   	int resp_len, ret, i;
> +	struct ib_sge sge;
>   	u8 srp_tm_status;
>   
> -	BUG_ON(!ch);
> +	if (WARN_ON(!ch))
> +		return;
>   
> +	sdev = ch->sport->sdev;
>   	state = ioctx->state;
>   	switch (state) {
>   	case SRPT_STATE_NEW:

Instead of making all these changes, please remove the BUG_ON(!ch) 
statement. If the condition ioctx->ch == NULL would ever be encountered 
then the call trace reported on the console will be sufficient to figure 
out what happened.

Thanks,

Bart.


