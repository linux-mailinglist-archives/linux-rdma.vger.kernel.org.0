Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058B7182173
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgCKTCA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 15:02:00 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37019 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgCKTCA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 15:02:00 -0400
Received: by mail-qv1-f68.google.com with SMTP id l17so1399268qvu.4
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XJiw1sKl9rxMrfBdqJ9bXzWcTic71GsdaVO23dnyWQk=;
        b=L62Gyk1wUwd6j7G1RVjq6G3PZFZ858annDCaFOfNzQeKKqQA3BnwMrgWFDPoCL2Mdu
         q8WJ5d0hbWY4Ezm2EUEWSPKE+JWLHdQ9pVHiUg3i2At4J50D/q2TbtjgYR9HffpK2JsQ
         gWLiD6nONl+lCswoQxfrUE5wFN/Lusc/+P31/fE0pGFd7am2Upnq/R/iNqolq/jNAnlp
         2e2hLfZY15EBe2AGCPRulTsb3Y0EGkRe6dvUMEQ3BWR/URHpNU6A4ol8w4MWtMSPVWxH
         UxJq0fpZ419ucKmqNTKpXQWI2Oprll3rA2AqPo0Dj6BrZ4NDbhBmpgtgAa4uBvFDj8Ee
         SlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJiw1sKl9rxMrfBdqJ9bXzWcTic71GsdaVO23dnyWQk=;
        b=H6nxBlQ7iw5+xFa8+MuNzxin+CeMeFLaB0WPqgNwCkladGOzhDVbh/jrGctfXwvo3x
         KQ9E15HLDtKoCe9sRCT4pmaRK6dvTOG4XlZAQCXKfukFlnkU7jkiaUkq4rKgYLoswAAw
         eZHvYkNbgMBUYjjChSXyjfqf0rZ4yUwA7dKPtz5xSpSON5WFD56KePVMy8RkDFcu74bf
         +qBQlB0+PD/pn6HXfLYYoPI2aQHgAiRTRmNeP5KX4Ecbv0R1nXZHCse5p1tTuOBsfYdg
         7b5y6SkyCTGe/IkAn3VP8G/p78WEerVxK01TWGnY1K7ff+VBPK7S2N7ktEPvVu6HWQIy
         wo+Q==
X-Gm-Message-State: ANhLgQ0j/rJTfVk9JS7dwO0M8g7N1rxRMBZ/w02q6s6Hyl86bwiBt1ab
        GejMf0kDktpOw3iI6Y8okcV4757uKBU=
X-Google-Smtp-Source: ADFU+vtNJvplI91N0vl2sIY2GzyytNwTRHhWVLc7gj19t+CfAIg31Heaf3dP9AZkIGgUm29X8/gwfg==
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr4019850qvm.131.1583953318152;
        Wed, 11 Mar 2020 12:01:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d22sm6393324qte.93.2020.03.11.12.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 12:01:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jC6c8-0001N2-EI; Wed, 11 Mar 2020 16:01:56 -0300
Date:   Wed, 11 Mar 2020 16:01:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v10 06/26] RDMA/rtrs: client: main functionality
Message-ID: <20200311190156.GH31668@ziepe.ca>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-7-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161240.30190-7-jinpu.wang@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 11, 2020 at 05:12:20PM +0100, Jack Wang wrote:
> +static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_sess *sess)
> +{
> +	struct rtrs_clt *clt = sess->clt;
> +	struct rtrs_clt_sess *next;
> +	bool wait_for_grace = false;
> +	int cpu;
> +
> +	mutex_lock(&clt->paths_mutex);
> +	list_del_rcu(&sess->s.entry);
> +
> +	/* Make sure everybody observes path removal. */
> +	synchronize_rcu();
> +
> +	/*
> +	 * At this point nobody sees @sess in the list, but still we have
> +	 * dangling pointer @pcpu_path which _can_ point to @sess.  Since
> +	 * nobody can observe @sess in the list, we guarantee that IO path
> +	 * will not assign @sess to @pcpu_path, i.e. @pcpu_path can be equal
> +	 * to @sess, but can never again become @sess.
> +	 */
> +
> +	/*
> +	 * Decrement paths number only after grace period, because
> +	 * caller of do_each_path() must firstly observe list without
> +	 * path and only then decremented paths number.
> +	 *
> +	 * Otherwise there can be the following situation:
> +	 *    o Two paths exist and IO is coming.
> +	 *    o One path is removed:
> +	 *      CPU#0                          CPU#1
> +	 *      do_each_path():                rtrs_clt_remove_path_from_arr():
> +	 *          path = get_next_path()
> +	 *          ^^^                            list_del_rcu(path)
> +	 *          [!CONNECTED path]              clt->paths_num--
> +	 *                                              ^^^^^^^^^
> +	 *          load clt->paths_num                 from 2 to 1
> +	 *                    ^^^^^^^^^
> +	 *                    sees 1
> +	 *
> +	 *      path is observed as !CONNECTED, but do_each_path() loop
> +	 *      ends, because expression i < clt->paths_num is false.
> +	 */
> +	clt->paths_num--;
> +
> +	/*
> +	 * Get @next connection from current @sess which is going to be
> +	 * removed.  If @sess is the last element, then @next is NULL.
> +	 */
> +	next = list_next_or_null_rr_rcu(&clt->paths_list, &sess->s.entry,
> +					typeof(*next), s.entry);

calling rcu list iteration without holding rcu_lock is wrong

> +	/*
> +	 * @pcpu paths can still point to the path which is going to be
> +	 * removed, so change the pointer manually.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct rtrs_clt_sess __rcu **ppcpu_path;
> +
> +		ppcpu_path = per_cpu_ptr(clt->pcpu_path, cpu);
> +		if (rcu_dereference(*ppcpu_path) != sess)

calling rcu_dereference without holding rcu_lock is wrong.

> +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> +				      struct rtrs_addr *addr)
> +{
> +	struct rtrs_clt *clt = sess->clt;
> +
> +	mutex_lock(&clt->paths_mutex);
> +	clt->paths_num++;
> +
> +	/*
> +	 * Firstly increase paths_num, wait for GP and then
> +	 * add path to the list.  Why?  Since we add path with
> +	 * !CONNECTED state explanation is similar to what has
> +	 * been written in rtrs_clt_remove_path_from_arr().
> +	 */
> +	synchronize_rcu();

This makes no sense to me. RCU readers cannot observe the element in
the list without also observing paths_num++

Please check all your RCU stuff carefully.

> +static void rtrs_clt_close_work(struct work_struct *work)
> +{
> +	struct rtrs_clt_sess *sess;
> +
> +	sess = container_of(work, struct rtrs_clt_sess, close_work);
> +
> +	cancel_delayed_work_sync(&sess->reconnect_dwork);
> +	rtrs_clt_stop_and_destroy_conns(sess);
> +	/*
> +	 * Sounds stupid, huh?  No, it is not.  Consider this sequence:

It sounds stupid because it is stupid. cancel_work is a giant race if
some other action hasn't been taken to block parallel threads from
calling queue_work before calling cancel_work.

> +static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
> +				  short port, size_t pdu_sz, void *priv,
> +				  void	(*link_ev)(void *priv, enum rtrs_clt_link_ev ev),
> +				  unsigned int max_segments,
> +				  unsigned int reconnect_delay_sec,
> +				  unsigned int max_reconnect_attempts)
> +{
> +	struct rtrs_clt *clt;
> +	int err;
> +
> +	if (!paths_num || paths_num > MAX_PATHS_NUM)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (strlen(sessname) >= sizeof(clt->sessname))
> +		return ERR_PTR(-EINVAL);
> +
> +	clt = kzalloc(sizeof(*clt), GFP_KERNEL);
> +	if (!clt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clt->pcpu_path = alloc_percpu(typeof(*clt->pcpu_path));
> +	if (!clt->pcpu_path) {
> +		kfree(clt);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	uuid_gen(&clt->paths_uuid);
> +	INIT_LIST_HEAD_RCU(&clt->paths_list);
> +	clt->paths_num = paths_num;
> +	clt->paths_up = MAX_PATHS_NUM;
> +	clt->port = port;
> +	clt->pdu_sz = pdu_sz;
> +	clt->max_segments = max_segments;
> +	clt->reconnect_delay_sec = reconnect_delay_sec;
> +	clt->max_reconnect_attempts = max_reconnect_attempts;
> +	clt->priv = priv;
> +	clt->link_ev = link_ev;
> +	clt->mp_policy = MP_POLICY_MIN_INFLIGHT;
> +	strlcpy(clt->sessname, sessname, sizeof(clt->sessname));
> +	init_waitqueue_head(&clt->permits_wait);
> +	mutex_init(&clt->paths_ev_mutex);
> +	mutex_init(&clt->paths_mutex);
> +
> +	clt->dev.class = rtrs_clt_dev_class;
> +	clt->dev.release = rtrs_clt_dev_release;
> +	dev_set_name(&clt->dev, "%s", sessname);

Missing error check on dev_set_name

> +	err = device_register(&clt->dev);
> +	if (err)
> +		goto percpu_free;

Wrong error unwind, read the kdoc for device_register

> +	err = rtrs_clt_create_sysfs_root_folders(clt);

sysfs creation that is not done as part of device_regsiter races with
udev.

> +	if (err)
> +		goto dev_unregister;

> +	return clt;
> +
> +dev_unregister:
> +	device_unregister(&clt->dev);

Wrong error unwind

> +percpu_free:
> +	free_percpu(clt->pcpu_path);
> +	kfree(clt);
> +	return ERR_PTR(err);
> +}

> +struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> +				 const char *sessname,
> +				 const struct rtrs_addr *paths,
> +				 size_t paths_num,
> +				 u16 port,
> +				 size_t pdu_sz, u8 reconnect_delay_sec,
> +				 u16 max_segments,
> +				 s16 max_reconnect_attempts)
> +{
> +	struct rtrs_clt_sess *sess, *tmp;
> +	struct rtrs_clt *clt;
> +	int err, i;
> +
> +	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
> +			ops->link_ev,
> +			max_segments, reconnect_delay_sec,
> +			max_reconnect_attempts);
> +	if (IS_ERR(clt)) {
> +		err = PTR_ERR(clt);
> +		goto out;
> +	}
> +	for (i = 0; i < paths_num; i++) {
> +		struct rtrs_clt_sess *sess;
> +
> +		sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
> +				  max_segments);
> +		if (IS_ERR(sess)) {
> +			err = PTR_ERR(sess);
> +			goto close_all_sess;
> +		}
> +		list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> +
> +		err = init_sess(sess);
> +		if (err)
> +			goto close_all_sess;
> +
> +		err = rtrs_clt_create_sess_files(sess);
> +		if (err)
> +			goto close_all_sess;
> +	}
> +	err = alloc_permits(clt);
> +	if (err)
> +		goto close_all_sess;
> +	err = rtrs_clt_create_sysfs_root_files(clt);
> +	if (err)
> +		goto close_all_sess;
> +
> +	/*
> +	 * There is a race if someone decides to completely remove just
> +	 * newly created path using sysfs entry.  To avoid the race we
> +	 * use simple 'opened' flag, see rtrs_clt_remove_path_from_sysfs().
> +	 */
> +	clt->opened = true;

A race solution without locks?

> +
> +	/* Do not let module be unloaded if client is alive */
> +	__module_get(THIS_MODULE);

Very strange.

> +static int __init rtrs_client_init(void)
> +{
> +	pr_info("Loading module %s, proto %s\n",
> +		KBUILD_MODNAME, RTRS_PROTO_VER_STRING);

No prints like this please

Jason
