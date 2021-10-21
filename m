Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE14367D5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 18:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJUQeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 12:34:02 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:40488 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhJUQeC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Oct 2021 12:34:02 -0400
Received: by mail-pl1-f182.google.com with SMTP id v20so788927plo.7;
        Thu, 21 Oct 2021 09:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DxZp4AcO+bnX5f5oSeqX9Zw466R7NR9oWDq0l2ri9l8=;
        b=J3GUpmVQf9TsgpMGAoS0wuIAL+RRwGI/4XSXpFuz4pyJFg3SMgF1+KY4rCXjswvw65
         OAat+UYTTGjIGb1FbPQdaqZOrUAG61B2IOPEownY8ZKh1F0pMGxLfrB6dw4DaCaDf2H1
         bPp+8b5Qc6ZL+2YRnh76mseNj2MBtUA/R859KBocoI1rYt3VAoDql2OVAyi5cZ2MaopQ
         rCqA/ogqt/JcW8tnXKiu/k0DG8mxaq8rOLN051wLPpOC+DG4JXA6hF/PbKh6Ba+sKakb
         Zy8T8mbk0GabMBux2TgXNHptrc+hiqj6sGKxkMXIORS9G7iTOeacZUlvPg3Ufs77+9MJ
         XV9w==
X-Gm-Message-State: AOAM5338DM/HhOBOXrhhjZKgAPdwFqL7j0V4+xVuOH9glb/yuTB+nbGw
        w4RTCFLSu1O2V6bKg6tz3tIOxrsWKaM=
X-Google-Smtp-Source: ABdhPJxnOy3ZKIC8kNYfkGWbl74R29IiC3/6mcPvfNteVUDLoKdFOuocZueEu97aVMVWesrJ7Eq/Lg==
X-Received: by 2002:a17:90a:c901:: with SMTP id v1mr7879191pjt.162.1634833905367;
        Thu, 21 Oct 2021 09:31:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:452c:8e0d:d8a1:4d6])
        by smtp.gmail.com with ESMTPSA id u66sm6759232pfc.114.2021.10.21.09.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 09:31:44 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] trace/hwlat: Make use of the helper macro
 kthread_run_on_cpu()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
References: <20211021122758.3092-1-caihuoqing@baidu.com>
 <20211021122758.3092-7-caihuoqing@baidu.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6c767079-e4fa-3ba3-1e0e-7b5c0d0a50c5@acm.org>
Date:   Thu, 21 Oct 2021 09:31:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021122758.3092-7-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/21 5:27 AM, Cai Huoqing wrote:
> Repalce kthread_create_on_cpu/wake_up_process()

Repalce -> Replace ?

Thanks,

Bart.
